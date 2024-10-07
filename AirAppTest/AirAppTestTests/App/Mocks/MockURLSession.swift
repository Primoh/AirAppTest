//
//  MockURLSession.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

@testable import AirAppTest
import Foundation

final class MockURLSession {
    var didCallData = false
    
    var dataFile: Data?
}

extension MockURLSession: URLSessionType {
    func data(
        with request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {
        didCallData = true
        guard let dataFile else { throw MockNetworkManagerError.noDataFile }
        return (dataFile, URLResponse())
    }
}
