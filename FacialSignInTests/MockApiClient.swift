//
//  MockApiClient.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation


class MockApiClient: ApiClient {
    
    enum JsonFileName: String {
        case identifyVisitorResponse = "IdentifyVisitorResponse"
        case identifyVisitorRequest = "IdentifyVisitorRequest"
        case potentialVisitorsResponse = "PotentialVisitorsResponse"
        case potentialVisitorsRequest = "PotentialVisitorsRequest"
        case newVisitorRequest = "NewVisitorRequest"
        case newVisitorResponse = "NewVisitorResponse"
    }
    
    var jsonFileName: JsonFileName = .identifyVisitorResponse
    var isNetworkRequestCalled = false
    var completionHandler: ((Data?, RequestError?) -> Void)!
    
    //Use mock response data
    override func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((Data?, RequestError?) -> Void)) {
        isNetworkRequestCalled = true
        guard let jsonData = JsonFileLoader.loadJson(fileName: jsonFileName.rawValue) else {
            completionHandler(nil, RequestError("Fetch Information failed."))
            return
        }
        completionHandler(jsonData, nil)
    }
    
    func fetchSuccess(data: Data?) {
        completionHandler(data, nil)
    }
    
    func fetchFail(error: RequestError?) {
        completionHandler(nil, error)
    }
}

class JsonFileLoader {
    
    class func loadJson(fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try NSData(contentsOf: url) as Data
            } catch let error {
                print("Error!! Unable to parse  \(fileName).json\n error: \(error)")
            }
            print("Error!! Unable to load  \(fileName).json")
        } else {
            print("invalid url")
        }
        return nil
    }
}
