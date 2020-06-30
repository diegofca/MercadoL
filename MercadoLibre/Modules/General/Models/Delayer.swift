//  Delayer.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class Delayer: Timer {
    var timer = Timer()
    
    override func invalidate() {
        timer.invalidate()
    }
    
    func addAction( timeInterval: Double = 1, loop: Bool = false, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: sleeve, selector: #selector(ClosureSleeve.invoke), userInfo: nil, repeats: loop)
    }
    
    static func addMainThreadAction( timeInterval: Double = .zero, _ closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            closure()
        }
    }
    
}
