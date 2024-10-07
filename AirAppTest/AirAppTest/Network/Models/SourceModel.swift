//
//  SourceModel.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

struct SourceModel: Codable {
    let measures: [String]
    let annotations: Annotations
    let name: String
}

// MARK: - Annotations
struct Annotations: Codable {
    let sourceName: String
    let sourceDescription: String
    let datasetName: String
    let datasetLink: String
    let tableID: String
    let topic: String
    let subtopic: String

    enum CodingKeys: String, CodingKey {
        case sourceName = "source_name"
        case sourceDescription = "source_description"
        case datasetName = "dataset_name"
        case datasetLink = "dataset_link"
        case tableID = "table_id"
        case topic, subtopic
    }
}
