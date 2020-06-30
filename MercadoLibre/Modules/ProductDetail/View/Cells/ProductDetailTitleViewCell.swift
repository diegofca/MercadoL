//  ProductDetailTitleViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class ProductDetailTitleViewCell: UITableViewCell {
    
    @IBOutlet private var titleLb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setProductTitle(_ title: String?) {
        titleLb.text = title
    }
    
}
