//  ProductDetailInteractor.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation


class ProductDetailInteractor {
    
    private var manager = ProductDetailManager()
      
    func requestProductDetail(productID: String, completion: @escaping (Product)->(), onError: @escaping (String?)->()) {
        manager.getProductDetail(productID: productID, completion: { product in
            completion(product)
        }, onError: onError)
    }
    
}
