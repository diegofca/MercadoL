//
//  CategoriesModel.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation

class CategoriesApiResponse: Model {
    var categories: [Category] = []

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        categories = try container.decodeArray(Category.self)
        super.init()
    }
}
