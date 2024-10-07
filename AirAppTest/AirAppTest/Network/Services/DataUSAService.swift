//
//  DataUSAService.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

enum DataUSARequestType: String {
    case nation = "Nation"
    case states = "State"
}

final class DataUSAService {
    
    private enum Constants {
        static let baseURL: String = "https://datausa.io/api/data"
        static let populationParameter: String = "Population"
    }
    
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
}

extension DataUSAService: DataUSAServiceType {
    func getNationInfo() async throws -> NationModel {
        let queryItems = createQueryParameters(with: .nation)
        return try await networkManager.makeURLRequest(
            modelType: NationModel.self,
            urlPath: Constants.baseURL,
            httpMethod: .get,
            headers: [.contentType: "application/json"],
            queryItems: queryItems
        )
    }
    
    func getStateInfo(to year: String) async throws -> StateModel {
        let queryItems = createQueryParameters(
            with: .states,
            year: year
        )
        return try await networkManager.makeURLRequest(
            modelType: StateModel.self,
            urlPath: Constants.baseURL,
            httpMethod: .get,
            headers: [.contentType: "application/json"],
            queryItems: queryItems
        )
    }
}

private extension DataUSAService {
    private func createQueryParameters(
        with type: DataUSARequestType,
        year: String? = nil
    ) -> [RequestParameter: Any] {
        var queryParameters: [RequestParameter: Any] = [
            .drilldowns: type.rawValue,
            .measures: Constants.populationParameter
        ]
        
        if let year {
            queryParameters[.year] = year
        }
        
        return queryParameters
    }
}
