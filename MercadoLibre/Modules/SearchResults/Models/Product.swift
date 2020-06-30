//  Product.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class Product: Model {
    
    let id: String
    let title: String
    let price: Double
    let currencyID: String
    let condition: String
    let thumbnail: String
    
    var pictures: [Picture] = []
    var stock: Int?
    var mercadoPago: Bool?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        price = try values.decode(Double.self, forKey: .price)
        currencyID = try values.decode(String.self, forKey: .currencyID)
        condition = try values.decode(String.self, forKey: .condition)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        mercadoPago = try values.decodeIfPresent(Bool.self, forKey: .mercadoPago)
        stock = try values.decodeIfPresent(Int.self, forKey: .stock)
        if let result = try? values.decodeArray(Picture.self, forKey: .pictures) {
            pictures = result
        }
        super.init()
    }
}

extension Product {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case currencyID = "currency_id"
        case condition
        case thumbnail
        case pictures
        case mercadoPago = "accepts_mercadopago"
        case stock = "available_quantity"
    }
}
