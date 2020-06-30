//  LogError.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 30/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class LogError {
    
    class func showError(errorMssg: String?){
        if let error = errorMssg {
            print("ERROR-", error)
        }
    }
    
    class func showError(error: Error?) {
        if let error = error?.localizedDescription {
            print("ERROR-", error)
        }
    }
    
}
