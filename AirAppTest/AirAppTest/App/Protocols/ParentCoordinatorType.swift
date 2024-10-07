//
//  ParentCoordinatorType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation

protocol ParentCoordinatorType: CoordinatorType {

    var childCoordinators: [CoordinatorType] { get set }

    func add(childCoordinator: CoordinatorType)
}

extension ParentCoordinatorType {

    func add(childCoordinator: CoordinatorType) {

        guard !childCoordinators.contains(where: { $0 === childCoordinator }) else {
            assertionFailure("Coordinator '\(childCoordinator.debugDescription())' is already a child of '\(self.debugDescription())'")
            return
        }

        childCoordinators.append(childCoordinator)
    }
}
