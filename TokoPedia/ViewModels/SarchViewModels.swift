//
//  SarchViewModels.swift
//  TokoPedia
//
//  Created by Mukesh mac on 04/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import Foundation

protocol SearchItemPresentable {
    var name: String {get}
    var price: String {get}
    var image_uri: String {get}
    var image_uri_700: String {get}
}

struct SearchItemViewModel: SearchItemPresentable {
    var name: String
    var price: String
    var image_uri: String
    var image_uri_700: String

}

class SearchViewModel {
    var items: [SearchItemViewModel] = []
    init(with items: [SearchItemViewModel]) {
        self.items = items
    }
    
}
