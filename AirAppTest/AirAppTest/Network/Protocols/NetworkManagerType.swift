//
//  NetworkManagerType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

protocol NetworkManagerType {
    func makeURLRequest<T: Decodable>(
        modelType: T.Type,
        urlPath: String,
        httpMethod: HTTPMethod,
        headers: [HeaderParameters: String],
        queryItems: [RequestParameter: Any]
    ) async throws -> T
}
