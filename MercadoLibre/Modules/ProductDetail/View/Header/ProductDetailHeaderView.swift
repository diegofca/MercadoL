//  ProductDetailHeaderView.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation
import UIKit

protocol ProductDetailHeaderViewDelegate {
    func favoriteClicked()
    func shareClicked()
    func buyClicked()
}

class ProductDetailHeaderView : UIView {
    
    @IBOutlet private var contentImageView: UIView!
    @IBOutlet private var pictureView: UIImageView!
    @IBOutlet private var buyBtn: UIButton!
    @IBOutlet private var shareBtn: UIButton!
    @IBOutlet private var favBtn: UIButton!
    @IBOutlet var effectView: UIVisualEffectView!
    
    var delegate: ProductDetailHeaderViewDelegate?

    var contentView: UIView!

    private func setViews() {
        contentImageView.shadowAndCorner(radius: 20)
        shareBtn.shadowAndCorner(radius: 20)
        buyBtn.shadowAndCorner(radius: 20)
        favBtn.shadowAndCorner(radius: 20)
        
        buyBtn.deleteActions()
        buyBtn.addAction(for: .touchUpInside) {
            self.delegate?.buyClicked()
        }
        
        shareBtn.deleteActions()
        shareBtn.addAction(for: .touchUpInside) {
            self.delegate?.shareClicked()
        }
        
        favBtn.deleteActions()
        favBtn.addAction(for: .touchUpInside) {
            self.delegate?.favoriteClicked()
        }
    }
    
    func setProductData(_ product: Product) {
        pictureView.loadImage(product.pictures.first?.url, with: 20)
    }
    
    //MARK: - CONSTRUCTOR VIEW
    convenience init(height: CGFloat, delegate: ProductDetailHeaderViewDelegate) {
        self.init(frame: CGRect(origin: .zero,
                                size: CGSize(width: UIScreen.main.bounds.width, height: height)))
        self.delegate = delegate
        xibSetup()
    }
     
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        self.addSubview(contentView)
        setViews()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProductDetailHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
     }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
