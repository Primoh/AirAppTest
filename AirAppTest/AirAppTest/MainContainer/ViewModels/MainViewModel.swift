//
//  MainViewModel.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Combine
import UIKit

final class MainViewModel {
    
    private enum RequestDataError: Error {
        case invalidNationSource
        case invalidNationData
        
        var description: String {
            switch self {
            case .invalidNationSource: "Invalid Nation Source after request"
            case .invalidNationData: "Invalid Nation Data after request"
            }
        }
    }
    
    private(set) var navigationBarTitlePublisher = PassthroughSubject<String, Never>()
    var navigationRightBarButtonImage: UIImage? { return UIImage(systemName: "line.3.horizontal.decrease.circle") }
    private(set) var nationInfoPublisher = PassthroughSubject<NationInfo, Never>()
    private(set) var populationInfoPublisher = CurrentValueSubject<PopulationInfoSection?, Never>(nil)
    private(set) var loadingVisiblePublisher = CurrentValueSubject<Bool, Never>(false)
    private(set) var yearsList: [String] = []
    
    private var nationDatasInfo: [NationData]?
    private var statesLoadingTask: Task<Void, Never>?
    
    private let dataUSAService: DataUSAServiceType
    private let flowOutput: MainFlowOutput
    
    init(
        dataUSAService: DataUSAServiceType,
        flowOutput: MainFlowOutput
    ) {
        self.dataUSAService = dataUSAService
        self.flowOutput = flowOutput
    }
}

private extension MainViewModel {
    private func loadData() {
        loadingVisiblePublisher.send(true)
        Task {
            do {
                let nationModel = try await dataUSAService.getNationInfo()
                nationDatasInfo = nationModel.data
                yearsList = nationModel.data.map {  $0.year }
                
                guard
                    let sourceName = nationModel.source.first?.annotations.sourceName
                else { throw RequestDataError.invalidNationSource }
                navigationBarTitlePublisher.send(sourceName)
                
                guard
                    let nationData = nationModel.data.first
                else { throw RequestDataError.invalidNationData }
                updateCurrentNationInfo(with: nationData)
                updateCurrentPopulationStatesInfo(to: nationData.year)
            } catch {
                let errorTitle = String(localized: "Error on Nation Request")
                var description = error.localizedDescription
                if let error = error as? RequestDataError {
                    description = error.description
                }
                flowOutput.onEventClosure(
                    .dialogError(
                        errorTitle,
                        description
                    )
                )
            }
        }
    }
    
    private func updateCurrentNationInfo(with nationData: NationData) {
        let nationInfo = NationInfo(
            nation: nationData.name,
            year: String(localized: "Year: \(nationData.year)"),
            population: String(localized: "Population: \(nationData.population)")
        )
        nationInfoPublisher.send(nationInfo)
    }
    
    private func updateCurrentPopulationStatesInfo(
        to year: String
    ) {
        statesLoadingTask?.cancel()
        statesLoadingTask = Task {
            do {
                let stateModel = try await dataUSAService.getStateInfo(to: year)
                let statesPopulationInfo = stateModel.data.map {
                    StatePopulationInfo(
                        name: $0.name,
                        population: String($0.population)
                    )
                }
                let sectionInfo = StatePopulationInfo(
                    name: String(localized: "State"),
                    population: String(localized: "Population")
                )
                let currentPopulationInfoSection = PopulationInfoSection(
                    info: sectionInfo,
                    cellsInfo: statesPopulationInfo
                )
                populationInfoPublisher.send(currentPopulationInfoSection)
                loadingVisiblePublisher.send(false)
            } catch {
                let errorTitle = String(localized: "Error on States Request")
                flowOutput.onEventClosure(
                    .dialogError(
                        errorTitle,
                        error.localizedDescription
                    )
                )
            }
            
        }
    }
}

extension MainViewModel: MainViewModelType {
    func viewDidLoad() {
        loadData()
    }
    
    func pickerViewDidSelectedIndex(at row: Int) {
        guard let nationInfo = nationDatasInfo?[safe: row] else { return }
        
        loadingVisiblePublisher.send(true)
        
        updateCurrentNationInfo(with: nationInfo)
        updateCurrentPopulationStatesInfo(to: nationInfo.year)
    }
}
