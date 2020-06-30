//  HomeInteractor.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 30/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class HomeInteractor {
    
    private var manager = HomeManager()
    
    func requestCategories(completion: @escaping ([Category])->(), onError: @escaping (String?)->()) {
        manager.getCategories(completion: { categoryList in
            let sortList = categoryList.sorted(by: { $0.name < $1.name })
            completion(sortList)
        }, onError: onError)
    }
  
    func requestDetailCategory(categoryID: String, completion: @escaping (Category)->(), onError: @escaping (String?)->()){
        manager.getCategoryDetail(categoryID: categoryID, completion: { detailCategory in
            detailCategory.expanded.toggle()
            completion(detailCategory)
        }, onError: onError)
    }
    
}
