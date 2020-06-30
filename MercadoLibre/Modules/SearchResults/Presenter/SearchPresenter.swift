//  SearchPresenter.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

protocol SearchPresenterDelegate {
    func getResultProducts( with query: String)
    func onError(_ mssg: String?)
}

class SearchPresenter {
    
    private lazy var interactor: SearchInteractor = {
        return SearchInteractor()
    }()
    private var delegate: SearchPresenterDelegate?
    private var delayer = Delayer()
    
    //dataSource
    var items = [Product]()
    
    //variables y constantes
    private let timerSearchDelay = 0.2
  
    init(delegate: SearchPresenterDelegate) {
        self.delegate = delegate
    }
    
    func searchProducts(query: String) {
        delayer.invalidate()
        delayer.addAction(timeInterval: timerSearchDelay) {
            self.interactor.requestSearchProducts(query: query, completion: { (items) in
                self.items = items
                self.delegate?.getResultProducts(with: query)
            }) { (error) in
                self.delegate?.onError(error)
                LogError.showError(errorMssg: error)
            }
        }
    }
    
}
