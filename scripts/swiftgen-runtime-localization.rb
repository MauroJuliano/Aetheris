#!/usr/bin/env ruby

path = ARGV.fetch(0)
source = File.read(path)

source.gsub!(
  /^(\s*)internal static let (`?\w+`?) = (Strings\.tr\([^\n]+\))$/,
  '\1internal static var \2: String { \3 }'
)

source.gsub!(
  'String(format: format, locale: Locale.current, arguments: args)',
  'String(format: format, locale: BundleToken.locale, arguments: args)'
)

bundle_token_pattern = /private final class BundleToken \{\n  static let bundle: Bundle = \{.*?\n  \}\(\)\n\}/m
bundle_token_replacement = <<~'SWIFT'.chomp
  private final class BundleToken {
    private static let baseBundle: Bundle = {
      #if SWIFT_PACKAGE
      return Bundle.module
      #else
      return Bundle(for: BundleToken.self)
      #endif
    }()

    static var bundle: Bundle {
      guard let languageCode else { return baseBundle }

      let candidates = [languageCode, String(languageCode.prefix(2))]
      for candidate in candidates {
        if let path = baseBundle.path(forResource: candidate, ofType: "lproj"),
           let localizedBundle = Bundle(path: path) {
          return localizedBundle
        }
      }

      return baseBundle
    }

    static var locale: Locale {
      languageCode.map(Locale.init(identifier:)) ?? .current
    }

    private static var languageCode: String? {
      switch UserDefaults.standard.string(forKey: "aetheris.selectedLanguage") {
      case "english": "en"
      case "german": "de"
      case "portugueseBrazil": "pt-BR"
      default: Locale.preferredLanguages.first
      }
    }
  }
SWIFT

unless source.sub!(bundle_token_pattern, bundle_token_replacement)
  abort "BundleToken pattern not found in #{path}"
end

File.write(path, source)
