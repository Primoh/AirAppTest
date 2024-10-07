//
//  NetworkManagerTests.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

@testable import AirAppTest
import XCTest

final class NetworkManagerTests: XCTestCase {
    
    private var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()

        sut = NetworkManager(urlSession: MockURLSession())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_case1() {
        XCTAssert(true)
    }
}
