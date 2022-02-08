//
//  EndPoint.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

public typealias JSON = [String : Any]

enum ApiError : Error {
    case serverError
    case parseError
    case internalError
    case invalidUrlError
    case internetOffline
    case maximumResultsReached
    
    var message : String {
        switch self {
        case .internetOffline:
            return "Please make sure you are connected to the internet"
        case .serverError :
            return "an internal error occured in server side please try again"
        case .maximumResultsReached:
            return "You have requested too many results. Developer accounts are limited to a max of 100 results."
        default:
            return "an internal error occured"
        }
    }
}

enum Method : String {
    case Get
    case Post
}

enum EndPoint  {
    case serachArticles
    var path : String {
        switch self {
        case .serachArticles:
            return "everything"
        }
    }
}
