//
//  ProductDetailManager.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation

class ProductDetailManager: NetworkManager {
    
    // call Product Detail API
    func getProductDetail(productID: String, completion: @escaping (Product)->(), onError: @escaping (String?)->()) {
        baseRequest(.productDetail(productID: productID) , completion: { (result: Result<Product>) in
            if let items = result.value {
                completion(items)
            }
        }) { (error) in
            onError(error)
        }
    }
    
}


