//
//  WorqoutError.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 09/01/25.
//

import Foundation

struct BEErrorMapper: MappeableType {

    typealias Result = BEError

    init() {}

    func map<T>(_ data: Data) -> T? {
        guard let response = decode(data) else { return nil }
        return response as? T
    }
}

struct BEError: Codable, Error {

    var code: String
    var message: String

    enum CodingKeys: String, CodingKey {
        case code
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = ""
        if let codeStr = try? container.decode(String.self, forKey: .code) {
            code = codeStr
        }
        if let codeInt = try? container.decode(Int.self, forKey: .code) {
            code = String(codeInt)
        }
        message = try container.decode(String.self, forKey: .message)
    }
}

public enum NetWorkError: Error {

    // MARK: - Internal errors
    case noInternet

    // MARK: - API errors
    case badAPIRequest

    // MARK: - Auth errors
    case unauthorized

    // MARK: - Unknown errors
    case unknown

    case doesNotExist
    
    case duplicateData
}
