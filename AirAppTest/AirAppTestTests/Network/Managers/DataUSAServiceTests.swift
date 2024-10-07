//
//  DataUSAServiceTests.swift
//  AirAppTest
//
//  Created by Daniel Primo on 06/10/2024.
//

@testable import AirAppTest
import XCTest

final class DataUSAServiceTests: XCTestCase {
    
    private var mockURLSession: MockURLSession!
    private var mockNetworkManager: MockNetworkManager!
    private var sut: DataUSAService!
    
    override func setUp() {
        super.setUp()
        
        mockURLSession = MockURLSession()
        mockNetworkManager = MockNetworkManager(mockURLSession: mockURLSession)
        sut = DataUSAService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockURLSession = nil
        mockNetworkManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_GetNationModel_validData_returnNationModel() async throws {
        mockURLSession.dataFile = makeValidNationData()
        let model: NationModel = try await sut.getNationInfo()
        XCTAssertTrue(mockNetworkManager.didCallMakeURLRequest)
        XCTAssertTrue(mockURLSession.didCallData)
        XCTAssertEqual(mockNetworkManager.httpMethod, .get)
        XCTAssertEqual(mockNetworkManager.urlPath, "https://datausa.io/api/data")
        XCTAssertEqual(mockNetworkManager.queryItems[RequestParameter.drilldowns] as? String, "Nation")
        XCTAssertEqual(mockNetworkManager.queryItems[RequestParameter.measures] as? String, "Population")
        XCTAssertEqual(mockNetworkManager.queryItems[RequestParameter.year] as? String, nil)
        XCTAssertTrue(model.data.count == 1)
    }
    
    func test_GetNationModel_noData_testFailed() async {
        do {
            _ = try await sut.getNationInfo()
            XCTFail("Expected to throw while awaiting, but succeeded")
        } catch {
            XCTAssertEqual(error as? MockNetworkManagerError, .noDataFile)
        }
    }
}

private extension DataUSAServiceTests {
    private func makeValidNationData() -> Data? {
        """
            {
               "data":[
                  {
                     "ID Nation":"01000US",
                     "Nation":"United States",
                     "ID Year":2022,
                     "Year":"2022",
                     "Population":331097593,
                     "Slug Nation":"united-states"
                  }
               ],
               "source":[
                  {
                     "measures":[
                        "Population"
                     ],
                     "annotations":{
                        "source_name":"Census Bureau",
                        "source_description":"The American Community Survey (ACS) is conducted by the US Census and sent to a portion of the population every year.",
                        "dataset_name":"ACS 5-year Estimate",
                        "dataset_link":"http://www.census.gov/programs-surveys/acs/",
                        "table_id":"B01003",
                        "topic":"Diversity",
                        "subtopic":"Demographics"
                     },
                     "name":"acs_yg_total_population_5",
                     "substitutions":[
                        
                     ]
                  }
               ]
            }
        """.data(using: .utf8)
    }
}
