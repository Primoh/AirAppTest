//
//  AppCoordinatorFactoryType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import UIKit

protocol AppCoordinatorFactoryType {
    func makeMainCoordinator(
        with navigationController: UINavigationController
    ) -> MainCoordinatorType
}
