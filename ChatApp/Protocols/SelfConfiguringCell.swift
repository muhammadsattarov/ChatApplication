//
//  Self.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with model: U)
}
