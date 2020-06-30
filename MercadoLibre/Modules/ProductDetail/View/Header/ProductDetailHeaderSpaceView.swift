//  ProductDetailHeaderSpaceView.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 29/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation
import UIKit

class ProductDetailHeaderSpaceView: UIView {
    
    @IBOutlet private var contentTopView: UIView!
    
    var contentView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setViews() {
        contentTopView.shadowAndCorner(radius: 25)
    }
    
    //MARK: - CONSTRUCTOR VIEW
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(origin: .zero,
                                size: CGSize(width: UIScreen.main.bounds.width, height: height)))
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
        let nib = UINib(nibName: "ProductDetailHeaderSpaceView", bundle: bundle)
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
