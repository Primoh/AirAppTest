//
//  AppCoordinatorFactory.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import UIKit

final class AppCoordinatorFactory: AppCoordinatorFactoryType {
    func makeMainCoordinator(with navigationController: UINavigationController) -> any MainCoordinatorType {
        let networkManager = NetworkManager()
        let dataUSAService = DataUSAService(networkManager: networkManager)
        let mainCoordnatorFactory = MainCoordinatorFactory(
            dataUSAService: dataUSAService
        )
        return MainCoordinator(
            navigationController: navigationController,
            factory: mainCoordnatorFactory,
            mainQueue: DispatchQueue.main
        )
    }
}
