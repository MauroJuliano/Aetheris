import Foundation

enum RegistrationInputRules {
    static func sanitizeSIN(_ value: String) -> String {
        formatSIN(digitsOnly: String(value.filter(\.isNumber).prefix(9)))
    }

    static func isValidSIN(_ value: String) -> Bool {
        value.range(of: #"^\d{3}\.\d{3}\.\d{3}$"#, options: .regularExpression) != nil
    }

    static func sanitizeName(_ value: String) -> String {
        value
            .filter { $0.isLetter || $0.isWhitespace }
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static func isValidName(_ value: String) -> Bool {
        sanitizeName(value).count >= 2
    }

    static func sanitizeBirthdate(_ value: String) -> String {
        formatBirthdate(digitsOnly: String(value.filter(\.isNumber).prefix(8)))
    }

    static func isValidBirthdate(_ value: String) -> Bool {
        guard value.range(of: #"^\d{2}/\d{2}/\d{4}$"#, options: .regularExpression) != nil else {
            return false
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.isLenient = false
        return formatter.date(from: value) != nil
    }

    private static func formatSIN(digitsOnly: String) -> String {
        var result = ""

        for (index, digit) in digitsOnly.enumerated() {
            if index == 3 || index == 6 {
                result.append(".")
            }
            result.append(digit)
        }

        return result
    }

    private static func formatBirthdate(digitsOnly: String) -> String {
        var result = ""

        for (index, digit) in digitsOnly.enumerated() {
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(digit)
        }

        return result
    }
}
