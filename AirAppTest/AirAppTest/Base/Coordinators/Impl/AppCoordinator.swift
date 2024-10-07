//
//  AppCoordinator.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import UIKit

final class AppCoordinator {
    
    var childCoordinators: [CoordinatorType] = []
    
    private var mainWindow: UIWindow?
    private lazy var rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.setupAppearence()
        return navigationController
    }()
    private var isReady: Bool = false
    
    private let factory: AppCoordinatorFactoryType
    
    init(factory: AppCoordinatorFactoryType) {
        self.factory = factory
    }
}

extension AppCoordinator: AppCoordinatorType {
    
    func setup(with window: UIWindow) {
        guard !isReady else {
            assertionFailure("Setup already completed...")
            return
        }

        window.rootViewController = rootNavigationController
        mainWindow = window
        
        isReady.toggle()
    }
    
    func start() {
        guard
            let mainWindow,
            isReady
        else {
            assertionFailure("Setup incomplete...")
            return
        }
        
        mainWindow.makeKeyAndVisible()
        let mainCoordinator = factory.makeMainCoordinator(with: rootNavigationController)
        add(childCoordinator: mainCoordinator)
        mainCoordinator.start()
    }
    
    
}

