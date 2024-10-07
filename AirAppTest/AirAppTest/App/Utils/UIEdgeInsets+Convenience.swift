//
//  UIEdgeInsets+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 05/10/2024.
//

import UIKit

extension UIEdgeInsets {
    static func all(value: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(
            top: value,
            left: value,
            bottom: value,
            right: value
        )
    }
}
