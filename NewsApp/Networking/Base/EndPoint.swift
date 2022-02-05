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
}

enum Method : String {
    case Get
    case Post
}

enum EndPoint  {
    case getArticles
    var path : String {
        switch self {
        case .getArticles:
            return ""
        }
    }
}
