//
//  Alamofire+PromiseKit.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

import Alamofire
import PromiseKit

extension Session {
    /// Triggers an HTTPRequest using Alamofire with a promise as a return type
    public static func requestWithPromise<T: Codable>(_ urlConvertible: Alamofire.URLRequestConvertible, cacheKey: String = "") -> Promise<T> {
        return Promise<T> { seal in
            
            // 1. Intenta cargar los datos desde el almacenamiento local (UserDefaults)
            if let cachedData = UserDefaults.standard.data(forKey: cacheKey),
               let cachedResponse = try? JSONDecoder().decode(T.self, from: cachedData) {
                seal.fulfill(cachedResponse)
            }
            
            // 2. Luego realiza la solicitud al servidor
            AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                // Check result from response and map it the promise
                
                if let data = response.data {
                    print("API - Returned JSON: \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
                } else {
                    print("API ERROR - Returned JSON")
                }
                
                switch response.result {
                case .success(let value):
                    
                    switch response.response?.statusCode {
                    case 422:
                        if let data = response.data, let error: BEError = BEErrorMapper().map(data) {
                            seal.reject(error)
                        } else {
                            seal.reject(NetWorkError.duplicateData)
                        }
                    default:
                        // 3. Guarda la respuesta en el almacenamiento local para futuras solicitudes
                        if let data = response.data {
                           if !cacheKey.isEmpty {
//                               SecureUserDefaults.shared.saveData(data, forKey: cacheKey)
                           }
                       }
                        seal.fulfill(value)
                    }
                    
                case .failure(let error):
                    print(error.errorDescription ?? "Unknown error")
                    print(error.localizedDescription)
                    
                    if let data = response.data {
                        print("API Error - Returned JSON: \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
                    }
                    
                    switch response.response?.statusCode {
                    case 401:
                        seal.reject(NetWorkError.unauthorized)
                    case 404:
                        seal.reject(NetWorkError.doesNotExist)
                    case 409:
                        seal.reject(NetWorkError.badAPIRequest)
                    default:
                        guard let data = response.data else {
                            guard NetworkReachabilityManager()?.isReachable ?? false else {
                                seal.reject(NetWorkError.noInternet)
                                return
                            }
                            seal.reject(NetWorkError.unknown)
                            return
                        }
                        if let error: BEError = BEErrorMapper().map(data) {
                            seal.reject(error)
                            return
                        } else {
                            seal.reject(NetWorkError.unknown)
                            return
                        }
                    }
                }
            }
        }
    }
}
