//  Category.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class Category: Model {
    let id: String
    let name: String
    var picture: String?
    var totalItems: Int?
    var subCategories = [SubCategory?]()
    var expanded: Bool = false

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
        totalItems = try values.decodeIfPresent(Int.self, forKey: .totalItems)
        if let result = try? values.decodeArray(SubCategory.self, forKey: .subCategories) {
            subCategories = result
        }
        super.init()
    }
}

extension Category {
    enum CodingKeys: String, CodingKey {
        case subCategories = "children_categories"
        case totalItems = "total_items_in_this_category"
        case picture
        case name
        case id
    }
}
