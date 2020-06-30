//  UITableViewExtension.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation
import UIKit

extension UITableView {
    
    func emptyMessage(_ message:String) {
        if numberOfRows(inSection: .zero) > .zero {
            resetEmptyState()
            return
        }
        
        let rect = CGRect(origin: .zero, size:
            CGSize(width: bounds.size.width, height: bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = .zero
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Neue", size: 15)
        messageLabel.sizeToFit()
        backgroundView = messageLabel
    }
    
    func resetEmptyState(){
        backgroundView = nil
    }
    
    func reloadDataFaded(duration: Double = 0.25) {
      UIView.transition(with: self,
        duration: duration,
        options: [.transitionCrossDissolve, .allowUserInteraction],
        animations: {
            self.reloadData()
            self.layoutIfNeeded()
      })
    }
    
}


