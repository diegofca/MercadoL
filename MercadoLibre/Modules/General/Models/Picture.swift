//  Picture.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class Picture: Model {

    let id: String
    let url: String
    let secureUrl: String
    let size: String
    let maxSize: String
    let quality: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        url = try values.decode(String.self, forKey: .url)
        secureUrl = try values.decode(String.self, forKey: .secureUrl)
        size = try values.decode(String.self, forKey: .size)
        maxSize = try values.decode(String.self, forKey: .maxSize)
        quality = try values.decode(String.self, forKey: .quality)
        super.init()
    }
}

extension Picture {
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case size
        case quality
        case secureUrl = "secure_url"
        case maxSize = "max_size"
    }
}
