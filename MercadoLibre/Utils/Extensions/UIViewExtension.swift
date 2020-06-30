//  Shadow.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import UIKit

extension UIView {
    func setShadow(_ backgroundColor: UIColor, opacity: Float = 1.0, radius: CGFloat = 8.0) {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.backgroundColor = backgroundColor
    }
    
    func shadowAndCorner(radius: Int) {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.4
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = false
    }
}
