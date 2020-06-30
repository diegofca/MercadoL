//  MutableCollection.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

extension MutableCollection {
    mutating func mutableMap(_ transform: (Element) throws -> Element) rethrows {
        var index = startIndex
        for element in self {
            self[index] = try transform(element)
            formIndex(after: &index)
        }
    }
}
