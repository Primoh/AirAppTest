//
//  MockDataUSAService.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

@testable import AirAppTest

final class MockDataUSAService {
    var didCallGetNationInfo = false
    var didCallGetStateInfo = false
}

extension MockDataUSAService: DataUSAServiceType {
    func getNationInfo() async throws -> NationModel {
        didCallGetNationInfo = true
        return NationModel(
            data: [],
            source: []
        )
    }
    
    func getStateInfo(to year: String) async throws -> StateModel {
        didCallGetStateInfo = true
        return StateModel(
            data: [],
            source: []
        )
    }
    
    
}
