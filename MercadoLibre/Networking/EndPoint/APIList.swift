//  APIList.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

/**
 `NOTA:` Listado de todas las APIS a consumir ordenadas por Modulo o genericas reusables.
*/

//MARK: APIS PATHS - 
public enum NetworkAPI {
    /// Home Search View
    case search(query: String)
    case categories
    case categoryDetail(categoryID: String)
    
    /// Product Detail View
    case productDetail(productID: String)
}
