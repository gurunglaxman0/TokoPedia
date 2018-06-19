//
//  SearchViewControllerSpec.swift
//  TokoPediaTests
//
//  Created by TheWarlock on 11/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Moya
@testable import TokoPedia



class SearchViewControllerSpec: QuickSpec {
    override func spec(){
        describe("SearchViewControllerSpec"){
            var sut:SearchViewController!
//
//
            beforeEach{
                sut = UIStoryboard.main.instantiate(.searchVC) as! SearchViewController
                sut.searchProvider = MoyaProvider<SearchServices>( stubClosure: { (_) -> StubBehavior in
                    .immediate
                })

                _ = sut.view
            }
//
            context("View Loaded") {
                it("Should have 10 rows in view Model") {
                    expect(sut.searchViewModel.items.count).to(equal(10))
                }
            }
        }
    }
}
