//  ProductDetailListPicturesViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

class ProductDetailListPicturesViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var imagesList: [Picture]? = []
    
    struct Constans {
        static let itemCell = "ProductDetailImageCollectionViewCell"
        static let edgeSideInset: CGFloat = 10
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        collectionView.register(UINib(nibName: Constans.itemCell, bundle: nil),
                                forCellWithReuseIdentifier: Constans.itemCell)
    }
    
    func setImagesList(imagesList: [Picture]?){
        self.imagesList = imagesList
        collectionView.reloadData()
        collectionView.invalidateIntrinsicContentSize()
    }
    
}

extension ProductDetailListPicturesViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constans.itemCell, for: indexPath) as! ProductDetailImageCollectionViewCell
        let imagePath = imagesList?[indexPath.row]
        cell.setImage(urlImage: imagePath?.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: Constans.edgeSideInset, bottom: .zero, right: Constans.edgeSideInset)
    }
}
