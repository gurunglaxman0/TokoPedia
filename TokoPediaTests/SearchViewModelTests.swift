//
//  SearchViewModelTests.swift
//  TokoPediaTests
//
//  Created by Mukesh mac on 04/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import XCTest
@testable import TokoPedia

class SearchViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyInitialization() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut = SearchViewModel(with: [])
        XCTAssertEqual(sut.items.count, 0)
    }
    
    func test_singleItemInitialization() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut = SearchViewModel(with: [SearchItemViewModel(name: "Test", price: "200", image_uri: "http://", image_uri_700: "http://")])
        XCTAssertEqual(sut.items.count, 1)
        let first = sut.items.first
        XCTAssertEqual(first?.name, "Test")
        XCTAssertEqual(first?.price, "200")
        XCTAssertEqual(first?.image_uri, "http://")
        XCTAssertEqual(first?.image_uri_700, "http://")
    }
    
    func test_twoItemInitialization() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut = SearchViewModel(with: [SearchItemViewModel(name: "Test 1", price: "200", image_uri: "http://", image_uri_700: "http://"),SearchItemViewModel(name: "Test 2", price: "200", image_uri: "http://", image_uri_700: "http://")])
        let first = sut.items.first
        let last = sut.items.last
        XCTAssertEqual(sut.items.count, 2)
        XCTAssertEqual(first?.name, "Test 1")
        XCTAssertEqual(last?.name, "Test 2")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
