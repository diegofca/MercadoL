//  SearchInteractor.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class SearchInteractor {
    
    private var manager = SearchManager()
    
    func requestSearchProducts(query: String, completion: @escaping ([Product])->(), onError: @escaping (String?)->()) {
        switch query.isEmpty  {
        case true:
            completion([])
        case false:
            manager.searchQuery(query: query, completion: { productList in
                let sortList = productList.sorted(by: { $0.title < $1.title })
                completion(sortList)
            }, onError: onError)
        }
    }
    
}
