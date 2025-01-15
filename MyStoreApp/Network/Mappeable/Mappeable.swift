//
//  Mappeable.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//


import Foundation

protocol Mappeable {
    func map<T>(_ date: Data) -> T?
}

protocol ResultType {
    associatedtype Result: Decodable
}

protocol MappeableType: ResultType, Mappeable {
    func decode(_ data: Data) -> Result?
}

extension MappeableType {
    func decode(_ data: Data) -> Result? {
        try? JSONDecoder().decode(Result.self, from: data)
    }
}
