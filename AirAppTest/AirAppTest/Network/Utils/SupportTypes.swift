//
//  SupportTypes.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation

enum HeaderParameters: String {
    case contentType = "Content-Type"
}

enum RequestParameter: String {
    case drilldowns
    case measures
    case year
}

enum HTTPMethod: String, Decodable, Equatable {
    case get = "GET"
}
