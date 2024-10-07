//
//  NSObject+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
