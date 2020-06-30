//  HomePresenter.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 30/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

protocol HomePresenterDelegate {
    func getResultCategories()
    func onError(_ mssg: String?)
}

class HomePresenter {
    
    private lazy var interactor: HomeInteractor = {
        return HomeInteractor()
    }()
    private var delegate: HomePresenterDelegate?
    private var delayer = Delayer()
      
    //dataSource
    var categories = [Category]()

    //variables y constantes
    private let timerSearchDelay = 0.2
    
    init(delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
    
    func getCategories() {
        interactor.requestCategories(completion: { categories in
            self.categories = categories
            self.delegate?.getResultCategories()
        }) { (error) in
            self.delegate?.onError(error)
            LogError.showError(errorMssg: error)
        }
    }
    
    private func resetCategoriesValues(_ category: Category) {
        categories.mutableMap { (currentCategory) -> Category in
            if currentCategory.id != category.id {
                currentCategory.expanded = false
            }
            return currentCategory
        }
    }
    
    func expandedCategory(_ category: Category) -> Bool {
        resetCategoriesValues(category)
        if let index = categories.firstIndex(where: {$0.id == category.id}) {
            categories[index].expanded.toggle()
            
            //MARK: - Valida si esta expandido para traer la informacion de la Categoria
            if categories[index].expanded {
                interactor.requestDetailCategory(categoryID: category.id, completion: { (categoryDetail) in
                    self.categories[index] = categoryDetail
                    self.delegate?.getResultCategories()
                }) { (error) in
                    self.delegate?.onError(error)
                    LogError.showError(errorMssg: error)
                }
            } else {
                self.delegate?.getResultCategories()
            }
            return categories[index].expanded
        }
        return false
    }
}
