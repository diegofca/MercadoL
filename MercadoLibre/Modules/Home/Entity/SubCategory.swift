//  SubCategory.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class SubCategory: Model {
    let id: String
    let name: String
    let totalItems: Int?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
        super.init()
    }
}

extension SubCategory {
    enum CodingKeys: String, CodingKey {
        case totalItems = "total_items_in_this_category"
        case picture
        case id
        case name
    }
}
