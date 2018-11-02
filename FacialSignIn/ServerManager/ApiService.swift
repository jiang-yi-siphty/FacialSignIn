//
//  ApiService.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation

enum RequestStatus {
    case success(AnyObject?)
    case fail(RequestError)
}

struct RequestError : LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }
    private var mMsg : String
    
    init(_ description: String) {
        mMsg = description
    }
    
    init(_ error: Error){
        mMsg = error.localizedDescription
    }
}

enum ApiConfig {
    case newVisitor
    case identifyVisitor
    case approveVisitor
    
    fileprivate static let FacialIdentifyServiceBaseUrl = "https://localhost:5000/facial_signin"
    fileprivate static let FacialIdentifyApiVersion = "/0" //If we need API version in the future.
    //We can define other web service here.
    
    var urlPath: String {
        switch self {
        case .newVisitor:
            return "/new_visitor"
        case .identifyVisitor:
            return "/identify_visitor"
        case .approveVisitor:
            return "/approve_visitor"
        }
    }
    
    var method: String {
        switch self {
        case .newVisitor:
            return "POST"
        case .identifyVisitor:
            return "POST"
        case .approveVisitor:
            return "POST"
        }
    }
    
    var header: [String: Any]?{
        switch self {
        case .newVisitor:
            return nil
        case .identifyVisitor:
            return nil
        case .approveVisitor:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .newVisitor:
            return nil
        case .identifyVisitor:
            return nil
        case .approveVisitor:
            return nil
        }
    }
    
    func getFullUrl() -> URL {
        var baseUrl: String!
        var version: String!
        switch self {
        case .newVisitor:
            baseUrl = ApiConfig.FacialIdentifyServiceBaseUrl
            version = ApiConfig.FacialIdentifyApiVersion
        case .identifyVisitor:
            baseUrl = ApiConfig.FacialIdentifyServiceBaseUrl
            version = ApiConfig.FacialIdentifyApiVersion
        case .approveVisitor:
            baseUrl = ApiConfig.FacialIdentifyServiceBaseUrl
            version = ApiConfig.FacialIdentifyApiVersion
        }
        
        if let url = URL(string: baseUrl + version + self.urlPath)  {
            return url
        } else {
            return URL(string: baseUrl)!
        }
    }
}

protocol ApiService {
    func networkRequest(_ config: ApiConfig, completionHandler: @escaping ((_ json: Data?, _ error: RequestError?) -> Void))
}
