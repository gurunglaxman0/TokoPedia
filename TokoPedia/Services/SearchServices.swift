//
//  SearchServices.swift
//  TokoPedia
//
//  Created by Mukesh mac on 03/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import Foundation
import Moya

enum SearchServices {
//    q=&pmin=10000&pmax=100000&wholesale=false&official=true&fshop=2&start=0&rows=1
    case search(q: String, rows: String, start:String, fshop: String, official: String, wholesale: String, pmax: String, pmin: String)
}


extension SearchServices:  TargetType {
    var baseURL: URL {
        return URL(string: "https://ace.tokopedia.com/")!
    }
    
    var path: String {
        switch self {
        case .search(_, _, _, _, _, _, _, _):
            return "/search/v2.5/product"
            
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .search(_, _, _, _, _, _, _, _):
            return .get
            
        }
    }
    
    var sampleData: Data {
        switch self {
        case .search(_, _, _, _, _, _, _, _):
            if let filepath = Bundle.main.path(forResource: "search", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    print(contents)
                    return contents.data(using: .utf8) ?? Data()
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }

            
        }
       return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let q, let rows, let start, let fshop, let official, let wholesale,let  pmax, let pmin):
            let params = [
                "q": q,
                "pmin": pmin,
                "pmax": pmax,
                "wholesale": wholesale,
                "official": official,
                "fshop": fshop,
                "start": start,
                "rows": rows,
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    
}
