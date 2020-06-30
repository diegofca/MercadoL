//  SearchProductTableViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit
import Kingfisher

class SearchProductTableViewCell: UITableViewCell {
    
    @IBOutlet private var contentBgView: UIView!
    @IBOutlet private var titleLb: UILabel!
    @IBOutlet private var previewImage: UIImageView!
    @IBOutlet private var priceLb: UILabel!
    @IBOutlet private var conditionLb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCellView()
    }
    
    private func setCellView() {
        selectionStyle = .none
        contentBgView.layer.cornerRadius = 10
        contentBgView.setShadow(.white)
    }

    func setDataItem(productItem: Product){
        previewImage.loadImage(productItem.thumbnail, with: 8)
        priceLb.text = "$ \(productItem.price) \(productItem.currencyID)"
        conditionLb.text = productItem.condition
        titleLb.text = productItem.title
    }
    
}
