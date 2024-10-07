//
//  UINavigationController+Convenience.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation
import UIKit

extension UINavigationController {

    func setupAppearence() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .white

        view.backgroundColor = .white
        navigationBar.tintColor = .black
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
