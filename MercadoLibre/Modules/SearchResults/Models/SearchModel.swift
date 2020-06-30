//  SearchModel.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class SearchApiResponse: Model {
    let siteID: String
    let query: String
    var items: [Product] = []
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        siteID = try values.decode(String.self, forKey: .siteID)
        query = try values.decode(String.self, forKey: .query)
        items = try values.decode([Product].self, forKey: .items)
        super.init()
    }
}

extension SearchApiResponse  {
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case items = "results"
        case query
    }
}
