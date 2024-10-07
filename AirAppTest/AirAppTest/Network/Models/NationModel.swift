//
//  NationModel.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

struct NationModel: Codable {
    let data: [NationData]
    let source: [SourceModel]
}

// MARK: - Datum
struct NationData: Codable {
    let id: String
    let name: String
    let yearID: Int
    let year: String
    let population: Int
    let slugNation: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID Nation"
        case name = "Nation"
        case yearID = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
