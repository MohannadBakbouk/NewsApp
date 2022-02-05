//
//  APIManagerProtocol.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import Foundation
protocol APIManagerProtocol {
    
    func request<T: Codable>(endpoint : EndPoint , method : Method , params :JSON? , completion : @escaping (Result <T , ApiError>)-> Void)
    
    func call<T: Codable>(with value : URLRequest , completion : @escaping (Result<T , ApiError>) -> ())
}
