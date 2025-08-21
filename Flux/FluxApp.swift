import SwiftUI

@main
struct FluxApp: App {
    func registerAllFontsInBundle() {
        let fontExtensions = ["ttf", "otf"]

        for ext in fontExtensions {
            guard let urls = Bundle.main.urls(forResourcesWithExtension: ext, subdirectory: nil) else { continue }
            for url in urls {
                guard let dataProvider = CGDataProvider(url: url as CFURL),
                      let font = CGFont(dataProvider) else { continue }

                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    print("Error registering font: \(String(describing: error))")
                } else {
                    print("Registered font: \(font.fullName ?? "" as CFString)")
                }
            }
        }
    }
    
    init() {
        registerAllFontsInBundle()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
