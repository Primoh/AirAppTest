//
//  MainViewModelType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Combine
import UIKit

protocol MainViewModelType {
    var navigationBarTitlePublisher: PassthroughSubject<String, Never> { get }
    var navigationRightBarButtonImage: UIImage? { get }
    var nationInfoPublisher: PassthroughSubject<NationInfo, Never> { get }
    var populationInfoPublisher: CurrentValueSubject<PopulationInfoSection?, Never> { get }
    var loadingVisiblePublisher: CurrentValueSubject<Bool, Never> { get }
    var yearsList: [String] { get }
    
    func viewDidLoad()
    func pickerViewDidSelectedIndex(at row: Int)
}
