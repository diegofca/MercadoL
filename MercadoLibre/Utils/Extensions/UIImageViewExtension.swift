//  UIImageViewExtension.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(_ path: String?, with radiusCorner: CGFloat){
        self.image = UIImage()
        if let path = path, let url = URL(string: path) {
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            self.kf.setImage(with: resource, options: [
                 .transition(ImageTransition.fade(0.2)),
                 .forceTransition,
                 .keepCurrentImageWhileLoading
            ])
            self.layer.cornerRadius = radiusCorner
        }
    }
}
