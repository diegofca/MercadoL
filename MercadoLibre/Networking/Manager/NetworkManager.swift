//  NetworkManager.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

enum NetworkResponse: String {
    case success
    case failed = "Solicitud fallida"
    case badRequest = "Solicitud incorrecta"
    case authenticationError = "Es necesario estar autenticado."
    case emptyData = "Respuesta devuelta sin datos para decodificar."
    case unableToDecode = "No pudimos decodificar la respuesta."
}

enum Result<T>{
    case success(value: T?)
    case failure(String)
    var value: T? {
        switch self {
            case .success(let value): return value
            case .failure: return nil
        }
    }
}

class NetworkManager {
    
    static let environment : NetworkEnvironment = .production
    let router = Router<NetworkAPI>()
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success(value: nil)
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    func baseRequest<T>(_ api: NetworkAPI, completion: @escaping (_ model: Result<T>)->(), onError: @escaping (String?)->()) {
        router.routeRequest(api) { data, response, error  in
            if let error = error {
                onError(error.localizedDescription)
                return
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        onError(NetworkResponse.emptyData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(api.modelResponse, from: responseData)

                        guard let value = apiResponse as? T else {
                            onError(NetworkResponse.unableToDecode.rawValue)
                            return
                        }
                        completion(.success(value: value))
                    
                    } catch {
                        onError(NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    onError(networkFailureError)
                }
            }
        }
    }
    
}
