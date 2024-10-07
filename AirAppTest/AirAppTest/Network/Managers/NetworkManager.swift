//
//  NetworkManager.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation

final class NetworkManager {

    private enum NetworkRequestError: Error {
        case invalidURL
        case invalidDateFormatterDecode
    }

    private let urlSession: URLSessionType

    init(urlSession: URLSessionType = URLSession.shared) {
        self.urlSession = urlSession
    }
}

private extension NetworkManager {
    private func buildURLRequest(
        with urlPath: String,
        httpMethod: HTTPMethod,
        headers: [HeaderParameters: String],
        queryItems: [RequestParameter: Any]
    ) async throws -> URLRequest {
        guard let url = URL(string: urlPath) else {
            throw NetworkRequestError.invalidURL
        }
        
        let urlQueryItems = queryItems.map {
            URLQueryItem(name: $0.key.rawValue, value: "\($0.value)")
        }

        let finalUrl = url.withQueryItems(urlQueryItems)

        var request = URLRequest(url: finalUrl)
        request.httpMethod = httpMethod.rawValue

        headers.forEach {
            request.addValue(
                $0.value,
                forHTTPHeaderField: $0.key.rawValue
            )
        }

        return request
    }
}

extension NetworkManager: NetworkManagerType {
    func makeURLRequest<T: Decodable>(
        modelType: T.Type,
        urlPath: String,
        httpMethod: HTTPMethod,
        headers: [HeaderParameters: String],
        queryItems: [RequestParameter: Any]
    ) async throws -> T {
        let request = try await buildURLRequest(
            with: urlPath,
            httpMethod: httpMethod,
            headers: headers,
            queryItems: queryItems
        )
        let (data, _) = try await urlSession.data(
            with: request,
            delegate: nil
        )
        
        return try JSONDecoder().decode(modelType, from: data)
    }
}
