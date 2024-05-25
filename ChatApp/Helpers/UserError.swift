//
//  UserError.swift
//  ChatApp
//
//  Created by user on 19/05/24.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotGetUserInfo
    case cannotUnwrapToMUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the lines", comment: "")
        case .photoNotExist:
            return NSLocalizedString("User did not select an image", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Don't get document in firebase", comment: "")
        case .cannotUnwrapToMUser:
            return NSLocalizedString("Can not convert MUser in User", comment: "")
        }
    }
}
