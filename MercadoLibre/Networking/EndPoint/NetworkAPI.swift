//  NetworkAPI.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

enum NetworkSite : String {
    case Argentina = "MLA"
    case Colombia = "MCO"
}


extension NetworkAPI: EndPointType {
    
    /**
     `NOTA:` Decidi crear la Capa de Networking y no usar `ALAMOFIRE` porque queria dejar agilizar la compilacion y el peso de la aplicacion.
    */
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.mercadolibre.com"
        case .qa: return "https://qa.mercadolibre.com"
        case .staging: return "https://staging.mercadolibre.com"
        }
    }
    
    //MARK: - Variables de red y entorno.
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("BASEURL no configurada") }
        return url
    }
    
    /// - Variable de configuracion de zona  en la peticion
    var site : NetworkSite {
        return .Argentina
    }
    
    /// - Complemento de path en la peticion
    var path: String {
        switch self {
        case .search:
            return "/sites/\(site.rawValue)/search"
            
        case .categories:
            return "/sites/\(site.rawValue)/categories"
            
        case .categoryDetail(let categoryID):
            return "/categories/\(categoryID)"
            
        case .productDetail(let productID):
            return "/items/\(productID)"
        }
    }
    
    /// - Tipo de metodo de la peticion
    var httpMethod: HTTPMethod {
        return .get
    }
    
    /// - Variable de configuracion de task en la peticion
    var task: HTTPTask {
        switch self {
        case .search(let query):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["q": query])
            
        case .categories, .categoryDetail, .productDetail:
            return .request
        }
    }
    
    /// - Variable de configuracion de headers en la peticion
    var headers: HTTPHeaders? {
        return nil
    }
    
    var modelResponse: Model.Type {
        switch self {
        case .search:
            return SearchApiResponse.self
            
        case .categories:
            return CategoriesApiResponse.self
            
        case .categoryDetail:
            return Category.self
            
        case .productDetail:
            return Product.self
            
        }
    }
}
