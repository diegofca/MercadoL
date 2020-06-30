//  HomeManager.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 30/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class HomeManager: NetworkManager {
    
    // call Categories API
    func getCategories(completion: @escaping ([Category])->(), onError: @escaping (String?)->()) {
        baseRequest(.categories, completion: { (result: Result<CategoriesApiResponse>) in
            if let items = result.value?.categories {
                completion(items)
            }
        }) { (error) in
            onError(error)
        }
    }
    
    func getCategoryDetail(categoryID: String, completion: @escaping (Category)->(), onError: @escaping (String?)->()) {
        baseRequest(.categoryDetail(categoryID: categoryID), completion: { (result: Result<Category>) in
             if let items = result.value {
                completion(items)
            }
        }) { (error) in
            onError(error)
        }
    }
    
}
