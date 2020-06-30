//
//  ProductDetailImageCollectionViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import UIKit

class ProductDetailImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var pictureView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(urlImage: String?){
        pictureView.loadImage(urlImage, with: 8)
        shadowAndCorner(radius: 8)
    }

}
