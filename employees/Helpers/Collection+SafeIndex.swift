//
//  Collection+SafeIndex.swift
//  employees
//
//  Created by Miroslav Ganchev on 23.11.23.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
