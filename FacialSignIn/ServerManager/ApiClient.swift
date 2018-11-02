//
//  ApiClient.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient: ApiService {
    
    func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((Data?, RequestError?) -> Void)) {
        networkRequestByNSURLSession(config, completionHandler: completionHandler)
    }
    
}

extension ApiClient {
    
    // We can use any of other network SDK to replace this , such as Alamofire or old NSURLConnection or AFNetworking
    fileprivate func networkRequestByNSURLSession(_ config: ApiConfig, completionHandler: @escaping ((_ jsonResponse: Data?, _ error: RequestError?) -> Void)) {
        URLCache.shared.removeAllCachedResponses()
        let url = config.getFullUrl()
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            self.responseHandler(data, error, completionHandler)
        }
        task.resume()
    }
    
    func networkRequestByAlamoFire(_ config: ApiConfig, completionHandler: @escaping ((_ jsonResponse: Data?, _ error: RequestError?) -> Void)) {
        URLCache.shared.removeAllCachedResponses()
        let url = config.getFullUrl()
        Alamofire.request(url).responseData(queue: DispatchQueue.global()) { response in
            guard let data = response.result.value else {
                print("Error: \(String(describing: response.result.error))")
                completionHandler(nil, RequestError((response.result.error?.localizedDescription)!))
                return
            }
            completionHandler(data, nil)
        }
    }
    
    fileprivate func responseHandler(_ data: Data?, _ error: Error?, _ completionHandler: @escaping ((_ jsonResponse: Data?, _ error: RequestError?) -> Void)){
        if let error = error {
            completionHandler(nil, RequestError(error.localizedDescription))
        } else if let data = data {
            completionHandler(data, nil)
        }
    }
    
}
