//
//  NetworkAPI.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/5/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
import Alamofire
struct NetworkingManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
}

class NetworkApi{
    
    class func sendRequest<T: Decodable>( userImage: Data? = nil, method: HTTPMethod, url: String, parameters:[String:Any]? = nil, header: [String:String]?  = nil, completion: @escaping (_ error: Error?, _ response: T?)->Void) {
        NetworkingManager.shared.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { res -> Void in
                print(res.result.value)
                switch res.result
                {
                case .failure(let error):
                    completion(error,nil)
                case .success(_):
                    if let dict = res.result.value as? Dictionary<String, Any>{
                        
                        do{
                            guard let data = res.data else { return }
                            let response = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,response)
                        }catch let err{
                            print("Error In Decode Data \(err.localizedDescription)")
                            completion(err,nil)
                        }
                    }else{
                        completion(nil,nil)
                    }
                }
        }
        
    }
}
 
