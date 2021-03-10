//
//  ListDemoTests.swift
//  ListDemoTests
//
//  Created by 张玥 on 2021/3/4.
//

import XCTest
@testable import ListDemo

class ListDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //测试接口正确性
    func testSendNetwork() {
        let urlSesssion = URLSession(configuration: URLSessionConfiguration.default)
        guard let url = URL(string: "​https://api.github.com/search/users?q=swift&page=1​") else { return }
        let dataTask = urlSesssion.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, "No data")
        }
        dataTask.resume()
    }
}
