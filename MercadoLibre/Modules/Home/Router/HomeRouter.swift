//  HomeRouter.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 30/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class HomeRouter: NavigationRouter {
    
    func goToSearchProducts(){
        let searchVc = SearchViewController.instantiate(storyboardName: .Main)
        pushController(searchVc)
    }

}
