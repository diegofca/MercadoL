//  SearchRouter.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class SearchRouter: NavigationRouter {
    
    func goToProductDetail(productID: String) {
        let detailVC = ProductDetailViewController.instantiate(storyboardName: .Main)
        detailVC.presenter.productID = productID
        presentController(detailVC)
    }
    
}
