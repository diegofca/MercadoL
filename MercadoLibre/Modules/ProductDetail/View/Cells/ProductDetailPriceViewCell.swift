//  ProductDetailPriceViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class ProductDetailPriceViewCell: UITableViewCell {
    
    @IBOutlet private weak var priceLb: UILabel!
    @IBOutlet private weak var stockLb: UILabel!
    
    struct Constants {
        static let availableStock = "Stock disponible"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setDataProduct(_ product: Product?) {
        guard let product = product else { return }
        priceLb.text = "$ \(product.price) \(product.currencyID)"
        if let stock = product.stock, stock > .zero {
            stockLb.text = "\(Constants.availableStock) (\(stock))"
        }
    }
    
}
