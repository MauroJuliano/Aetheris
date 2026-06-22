import SwiftUI

protocol MothersNameInputServicing {
    func submitMothersName(_ mothersName: String) async throws -> RegisterModel
}

enum RegisterError: Error {
    case invalidData
    case invalidResponse
    case invalidUrl
}

final class MothersNameInputService: MothersNameInputServicing {
    let endpoint = ""
    
    func submitMothersName(_ mothersName: String) async throws -> RegisterModel {
        return RegisterModel(mothersName: mothersName)
    }
}
