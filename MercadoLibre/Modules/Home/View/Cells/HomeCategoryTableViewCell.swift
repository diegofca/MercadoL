//  SearchCategoryTableViewCell.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

protocol HomeCategoryTableViewDelegate {
    func onSelectSubCategory(_ subCategory: SubCategory)
}

class HomeCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet private var contentBgView: UIView!
    @IBOutlet private var subCategoriesCollectionView: UICollectionView!
    @IBOutlet private var titleLb: UILabel!
    @IBOutlet private var totalItemsLb: UILabel!
    @IBOutlet private var pictureView: UIImageView!
    @IBOutlet private var detailCtrLayout: NSLayoutConstraint!
    
    private var categoryItem: Category!
    var delegate: HomeCategoryTableViewDelegate?

    struct Constants {
        static let nameCell = "HomeSubCategorieCollectionViewCell"
        static let heigthCell: CGFloat = 300
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setCellView()
    }
    
    private func setCellView() {
        selectionStyle = .none
        contentBgView.setShadow(.white)
        contentBgView.layer.cornerRadius = 10
        subCategoriesCollectionView.register(UINib(nibName: Constants.nameCell, bundle: nil),
                                             forCellWithReuseIdentifier: Constants.nameCell)
    }

    func setDataItem(categoryItem: Category){
        self.categoryItem = categoryItem
        detailCtrLayout.constant = categoryItem.expanded ? Constants.heigthCell : .zero
        titleLb.text = categoryItem.name
        pictureView.loadImage(categoryItem.picture, with: .zero)
        totalItemsLb.text = "\(categoryItem.totalItems ?? .zero) productos disponibles."
        subCategoriesCollectionView.reloadData()
    }
    
}

extension HomeCategoryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItem.expanded ? categoryItem.subCategories.count : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nameCell, for: indexPath) as! HomeSubCategorieCollectionViewCell
        if let subCategory = categoryItem.subCategories[indexPath.row] {
            cell.setDataItem(subCategoryItem: subCategory)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/1.3, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let subCategory = categoryItem.subCategories[indexPath.row] {
            delegate?.onSelectSubCategory(subCategory)
        }
    }
    
}
