//
//  NetworkConstants.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 09/01/25.
//

import Foundation

struct NetworkConstants {

    /// Base URL
    static let baseURL = Environment.rootURL.absoluteString
   

    /// The keys for HTTP header fields
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    /// The values for HTTP header fields
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
    }
}
