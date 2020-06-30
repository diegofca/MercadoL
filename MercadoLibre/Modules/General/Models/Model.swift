//  Model.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 27/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation

class Model : Codable { }

//MARK: - Decodable container para respuesta NSARRAY
extension UnkeyedDecodingContainer {
    
    public mutating func decodeArray<T>(_ type: T.Type) throws -> [T] where T : Decodable {
        var array = [T]()
        while !self.isAtEnd {
            do {
                if let item = try self.decodeIfPresent(T.self) {
                    array.append(item)
                }
            } catch _ { }
        }
        return array
    }
}

extension KeyedDecodingContainerProtocol {
    
    public func decodeArray<T>(_ type: T.Type, forKey key: Self.Key) throws -> [T] where T : Decodable {
        var unkeyedContainer = try self.nestedUnkeyedContainer(forKey: key)
        return try unkeyedContainer.decodeArray(type)
    }
    
}
