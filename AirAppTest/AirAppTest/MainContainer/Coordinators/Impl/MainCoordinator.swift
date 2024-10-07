//
//  MainCoordinator.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import UIKit

final class MainCoordinator {
    
    private let navigationController: UINavigationController
    private let factory: MainCoordinatorFactoryType
    private let mainQueue: DispatchMainQueueType
    
    init(
        navigationController: UINavigationController,
        factory: MainCoordinatorFactoryType,
        mainQueue: DispatchMainQueueType
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.mainQueue = mainQueue
    }
}

extension MainCoordinator: MainCoordinatorType {
    func start() {
        let mainFlowOutput = MainFlowOutput { [weak self] event in
            self?.onMainFlowOutputEvent(event: event)
        }
        let mainViewController = factory.makeMainViewController(with: mainFlowOutput)
        navigationController.setViewControllers(
            [mainViewController],
            animated: false
        )
    }
}

private extension MainCoordinator {
    private func onMainFlowOutputEvent(event: MainFlowOutput.Events) {
        switch event {
        case .dialogError(let title, let description):
            presentAlertView(
                title: title,
                description: description
            )
            break
        }
    }
    
    private func presentAlertView(
        title: String,
        description: String
    ) {
        let alertView = factory.makeDialogErrorAlertView(
            title: title,
            description: description
        )
        
        mainQueue.asyncThread { [weak self] in
            self?.navigationController.present(
                alertView,
                animated: true
            )
        }
        
    }
}
