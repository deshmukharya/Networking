//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by E5000861 on 12/06/24.
//

import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {


        var viewController = ViewController()

        override func setUpWithError() throws {
            // Instantiate the ViewController from your storyboard or directly
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerID") as? ViewController ?? viewController.view as! ViewController
            _ = viewController.view // Ensure viewDidLoad() is called
        }

        override func tearDownWithError() throws {
           
        }

        func testGetCall() throws {
            // Mock URLSession data and response
            
                let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/users")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let mockData = """
            [
                {"id": 1, "name": "John Doe", "username": "johndoe", "address": {"city": "New York"}, "company": {"name": "ACME"}},
                {"id": 2, "name": "Jane Smith", "username": "janesmith", "address": {"city": "Los Angeles"}, "company": {"name": "XYZ"}}
            ]
            """.data(using: .utf8)!
                let mockSession = MockURLSession(data: mockData, response: mockResponse, error: nil)
                viewController.urlSession = mockSession
                viewController.getCall(_sender: self)
            
            // Validate the expected output or behavior, for example, by asserting against printed logs
            // Modify as per actual expected behavior in your application
        }

        func testPutCall() throws {
            // Mock URLSession data and response
           
                let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/users/1")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                let mockData = """
            {"id": 1, "name": "Arya", "username": "arya", "address": {"city": "updatedcity"}, "company": {"name": "updatedcompany"}}
            """.data(using: .utf8)!
                let mockURLSession = MockURLSession(data: mockData,response : mockResponse,error: nil)
                viewController.putCall(self)

        }
   
      
    func testDeleteCall() throws {
            // Mock URLSession data and response
            let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/users/1")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let mockData = """
            {"success": true}
            """.data(using: .utf8)!
        let mockSession = MockURLSession(data: mockData, response: mockResponse, error: nil)
        viewController.urlSession = mockSession

            // Trigger the deleteCall action
            viewController.deleteCall(self)

            // Wait for the async task to complete
            let expectation = XCTestExpectation(description: "Wait for async task")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)

            // Validate the expected output or behavior, for example, by asserting against printed logs
            // Modify as per actual expected behavior in your application
        }

     

        func testPostCall() throws {
            // Mock URLSession data and response
                let mockResponse = HTTPURLResponse(url: URL(string: "https://jsonplaceholder.typicode.com/users")!, statusCode: 201, httpVersion: nil, headerFields: nil)!
                let mockData = """
            {"id": 21, "name": "Arya", "username": "arya", "address": {"city": "aakn"}, "company": {"name": "innov"}}
            """.data(using: .utf8)!
                
                let mockSession = MockURLSession(data: mockData, response: mockResponse, error: nil)
                viewController.urlSession = mockSession
                viewController.postCall(self)
            }
       
        }
    
class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        mockData = data
        mockResponse = response
        mockError = error
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(mockData: mockData, mockResponse: mockResponse, mockError: mockError, completionHandler: completionHandler)
    }
}
class MockURLSessionDataTask: URLSessionDataTask {
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void

    private let mockResponse: URLResponse?
    private var mockError: Error?
    private let mockData: Data?
    init(mockData: Data?, mockResponse: URLResponse?, mockError: Error?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.mockData = mockData
        self.mockResponse = mockResponse
        self.mockError = mockError
        self.completionHandler = completionHandler
    }


    
    override func resume() {
        completionHandler(mockData, mockResponse, mockError)
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
       
    }
}
    // Helper class to mock URLSession for testing purposes
   

  

