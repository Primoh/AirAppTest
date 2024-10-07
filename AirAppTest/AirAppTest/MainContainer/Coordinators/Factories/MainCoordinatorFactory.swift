//
//  MainCoordinatorFactory.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Combine
import UIKit

final class MainCoordinatorFactory {
    
    private let dataUSAService: DataUSAServiceType
    
    init(
        dataUSAService: DataUSAServiceType
    ) {
        self.dataUSAService = dataUSAService
    }
}

extension MainCoordinatorFactory: MainCoordinatorFactoryType {
    func makeMainViewController(with flowOutput: MainFlowOutput) -> MainViewController {
        let mainViewModel = MainViewModel(
            dataUSAService: dataUSAService,
            flowOutput: flowOutput
        )
        return MainViewController(viewModel: mainViewModel)
    }
    
    func makeDialogErrorAlertView(
        title: String,
        description: String
    ) -> UIAlertController {
        let dialogErrorAlertView = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(
            title: String(localized: "OK"),
            style: .cancel
        ) { _ in
            dialogErrorAlertView.dismiss(animated: true)
        }
        dialogErrorAlertView.addAction(cancelAction)
        
        return dialogErrorAlertView
    }
}
