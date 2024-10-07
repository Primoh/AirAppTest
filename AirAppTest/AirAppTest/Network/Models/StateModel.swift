//
//  StateModel.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

struct StateModel: Codable {
    let data: [StateData]
    let source: [SourceModel]
}

struct StateData: Codable {
    let id: String
    let name: String
    let yearID: Int
    let year: String
    let population: Int
    let slugState: String

    enum CodingKeys: String, CodingKey {
        case id = "ID State"
        case name = "State"
        case yearID = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
