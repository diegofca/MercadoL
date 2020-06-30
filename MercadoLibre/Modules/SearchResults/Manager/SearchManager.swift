//  SearchManager.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class SearchManager: NetworkManager {
    
    // call Search Query API
    func searchQuery(query: String, completion: @escaping ([Product])->(), onError: @escaping (String?)->()) {
        baseRequest(.search(query: query), completion: { (result: Result<SearchApiResponse>) in
            if let items = result.value?.items {
                completion(items)
            }
        }) { (error) in
            onError(error)
        }
    }
    
}
