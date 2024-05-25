//
//  Bundle+Extension.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in bundle")
        }
        let decoder = JSONDecoder()
        guard let loader = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) in bundle")
        }
        return loader
    }
}
