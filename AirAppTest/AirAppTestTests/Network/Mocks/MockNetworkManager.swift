//
//  MockNetworkManager.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

@testable import AirAppTest
import Foundation

enum MockNetworkManagerError: Error {
    case noDataFile
    case invalidURLPath
}

final class MockNetworkManager {
    
    var urlPath: String?
    var httpMethod: HTTPMethod?
    var headers: [HeaderParameters: String] = [:]
    var queryItems: [RequestParameter: Any] = [:]
    
    private(set) var didCallMakeURLRequest = false
    
    private let mockURLSession: MockURLSession
    
    init(mockURLSession: MockURLSession) {
        self.mockURLSession = mockURLSession
    }
}

extension MockNetworkManager: NetworkManagerType {
    func makeURLRequest<T: Decodable>(
        modelType: T.Type,
        urlPath: String,
        httpMethod: HTTPMethod,
        headers: [HeaderParameters: String],
        queryItems: [RequestParameter: Any]
    ) async throws -> T {
        didCallMakeURLRequest = true
        self.urlPath = urlPath
        self.httpMethod = httpMethod
        self.headers = headers
        self.queryItems = queryItems
        guard let url = URL(string: urlPath) else { throw MockNetworkManagerError.invalidURLPath}
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await mockURLSession.data(
            with: urlRequest,
            delegate: nil
        )
        return try JSONDecoder().decode(modelType, from: data)
    }
    
    
}
