//
//  Network.swift
//  Movie Flix
//
//  Created by apple on 08/12/21.
//

import Foundation
import Alamofire

typealias completion = (Response<Any>)-> Void

enum Response<T> {
    case sucess(value: T)
    case Apifaile(T)
    case error(value: T)
}

class NetworkManager {
    
    private static var manager: NetworkManager = {
        let shared = NetworkManager()
        return shared
    }()
    
    class func shared() -> NetworkManager {
        return manager
    }
    
    func request<T: Decodable>( _ url: String, _ model: T.Type,_ handler: @escaping completion) {
        if  (NetworkReachabilityManager()?.isReachable ?? false) {
            Session.default.request(url).responseDecodable(of: model.self) { response in
                
                guard let statusCode = response.response?.statusCode else { return }
               
                switch statusCode {
                case 200...201:
                    let object = Response<Any>.sucess(value: response.value ?? T.self)
                    handler(object)
                    break
                case 500:
                    let error = Response<Any>.Apifaile("something went wrong server")
                    handler(error)
                    break
                case 400...401:
                    let error = Response<Any>.error(value: "Permission denied")
                    handler(error)
                    break
                default:
                    break
                }
            }
        } else {
            let error = Response<Any>.error(value: "Please check network and try again")
            handler(error)
        }
        
    }
    
}
