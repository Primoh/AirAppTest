//
//  Collection+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
