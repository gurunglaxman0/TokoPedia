//
//  SearchViewControllerTests.swift
//  TokoPediaTests
//
//  Created by Mukesh mac on 04/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import XCTest
@testable import Moya
@testable import TokoPedia
class SearchViewControllerTests: XCTestCase {
    var searchVC: SearchViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        searchVC = UIStoryboard.main.instantiate(.searchVC) as! SearchViewController
        searchVC.searchProvider = MoyaProvider<SearchServices>( stubClosure: { (_) -> StubBehavior in
            .immediate
        })
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSearchResult() {
        searchVC.view.layoutIfNeeded()
        XCTAssertEqual(searchVC.searchViewModel.items.count , 10)
    }
    
    
    func testPrductName() {
        searchVC.view.layoutIfNeeded()
        let last = searchVC.searchViewModel.items.last
        XCTAssertEqual(last?.name , " Case Macbook Pro Retina 15 Inch Yellow")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
