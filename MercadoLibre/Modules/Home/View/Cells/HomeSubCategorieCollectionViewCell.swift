//  SearchCategorieCollectionViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class HomeSubCategorieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var contentBgView: UIView!
    @IBOutlet private var titleLb: UILabel!
    @IBOutlet private var totalItemsLb: UILabel!
    
    struct Constants {
        static let availableProducts = "productos disponibles."
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellView()
    }
    
    private func setCellView() {
        contentBgView.layer.cornerRadius = 10
        contentBgView.setShadow(.white, opacity: 0.5)
    }
    
    func setDataItem(subCategoryItem: SubCategory){
        titleLb.text = subCategoryItem.name
        totalItemsLb.text = "\(subCategoryItem.totalItems ?? .zero) \(Constants.availableProducts)"
    }

}
