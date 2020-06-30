//  NavigationRouter.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation
import UIKit

protocol Coordinator {
    var navController: UINavigationController { get set }
}

protocol Storyboarded {
    static func instantiate(storyboardName: AppStoryboard) -> Self
}

class NavigationRouter: Coordinator {
    var navController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navController = navigationController
    }
    
    func pushController(_ vc: UIViewController, animated: Bool = true, barHidden: Bool = false){
        navController.isNavigationBarHidden = barHidden
        navController.pushViewController(vc, animated: animated)
    }
    
    func presentController(_ vc: UIViewController, animated: Bool = true, barHidden: Bool = false) {
        navController.present(vc, animated: animated)
    }
       
    func pop(animated: Bool = true) {
        navController.popViewController(animated: animated)
    }
}

//MARK: - Listado de Storyboards o XIBS para VCs
enum AppStoryboard: String {
    case Main = "Main"
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: AppStoryboard) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
