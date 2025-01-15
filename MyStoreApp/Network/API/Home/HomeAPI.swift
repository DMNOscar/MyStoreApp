//
//  HomeAPI.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import Foundation
import Alamofire

enum HomeAPI: URLRequestConvertible {
    
    // MARK: - Endpoints
    case getAllProducts
    case getCategories
    case getProductsByCategory(String)

    // MARK: - Properties
    private var method: HTTPMethod {
        switch self {
        case .getAllProducts, .getCategories, .getProductsByCategory:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .getAllProducts:
            return "products"
        case .getCategories:
            return "products/categories"
        
        case .getProductsByCategory(let name):
            return "products/category/\(name)"
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getAllProducts, .getCategories, .getProductsByCategory(_):
            return nil
        }
    }

    private var body: Parameters? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        // Construct url
        let url = try NetworkConstants.baseURL.asURL()

        // Append path
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // Determine HTTP method
        urlRequest.httpMethod = method.rawValue

        // Set common headers
        urlRequest.setValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
                            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.contentType.rawValue)

        
        
        urlRequest.setValue(
            "", forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.authorization.rawValue)

        // Add http body to request
        if let body = body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = data
            } catch (_) {
                print("APIRouter: Failed to parse body into request.")
            }
        }

        // Add query parameters to request
        if let parameters = parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        print("URL Request \(urlRequest)")
        return urlRequest
    }
}
