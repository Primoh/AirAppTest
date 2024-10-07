//
//  DataUSAServiceType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

protocol DataUSAServiceType {
    func getNationInfo() async throws -> NationModel
    func getStateInfo(to year: String) async throws -> StateModel
}
