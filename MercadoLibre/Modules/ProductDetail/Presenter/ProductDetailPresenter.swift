//  ProductDetailPresenter.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

protocol ProductDetailPresenterDelegate {
    func onLoadProduct(_ product: Product)
    func onError(_ mssg: String?)
}

enum ProductDetailCellType {
    case Title
    case Description
    case Price
    case Images
    case Rating
    case MercadoPago
    case Condition
}

class ProductDetailPresenter {
    
    private lazy var interactor: ProductDetailInteractor = {
        return ProductDetailInteractor()
    }()
    private var delegate: ProductDetailPresenterDelegate?
    private var delayer = Delayer()
    
    var productID: String?
    var product: Product?
    var itemsCell: [ProductDetailCellType] = [.Title, .Price, .Images, .Description]
    
    //MARK: - INIT
    init(delegate: ProductDetailPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getProductDetail() {
        guard let productID = productID else { return }
        interactor.requestProductDetail(productID: productID, completion: { product in
            self.delegate?.onLoadProduct(product)
            self.product = product
        }) { (error) in
            self.delegate?.onError(error)
            LogError.showError(errorMssg: error)
        }
    }
    
}
