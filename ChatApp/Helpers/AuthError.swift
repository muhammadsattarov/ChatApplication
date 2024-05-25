//
//  AuthError.swift
//  ChatApp
//
//  Created by user on 19/05/24.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the lines", comment: "")
        case .invalidEmail:
            return NSLocalizedString("The mail format is not valid", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Passwords is not matched", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        }
    }
}
