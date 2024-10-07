//
//  MainCoordinatorFactoryType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import UIKit

protocol MainCoordinatorFactoryType {
    func makeMainViewController(with flowOutput: MainFlowOutput) -> MainViewController
    func makeDialogErrorAlertView(
        title: String,
        description: String
    ) -> UIAlertController
}
