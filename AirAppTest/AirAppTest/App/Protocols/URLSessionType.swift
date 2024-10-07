//
//  URLSessionType.swift
//  AirAppTest
//
//  Created by Daniel Primo on 04/10/2024.
//

import Foundation

protocol URLSessionType {
    func data(
        with request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {
    func data(
        with request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {
        try await data(
            for: request,
            delegate: delegate
        )
    }
}
