//
//  CoordinatorType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation

protocol CoordinatorType: AnyObject {

    func start()
}

extension CoordinatorType {

    func debugDescription() -> String {
        NSStringFromClass(type(of: self))
    }
}
