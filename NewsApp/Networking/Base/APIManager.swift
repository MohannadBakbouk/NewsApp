//
//  APIManager.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import Foundation

class APIManager : APIManagerProtocol {
    
    func request<T : Codable>(endpoint: EndPoint, method: Method, params: JSON?, completion: @escaping (Result<T, ApiError>) -> ()) {
        
        let urlStr = "\(API.url.rawValue)\(endpoint.path)"
        guard var urlComp = URLComponents(string: urlStr) else {
            completion(.failure(.invalidUrlError))
            return
        }
        if let body = params , method == .Get {
            urlComp.queryItems = []
            for item in body {
                let value = String(describing: item.value)
                urlComp.queryItems!.append(URLQueryItem(name: item.key, value: value))
            }
        }
        var request = URLRequest(url: urlComp.url!)
        request.httpMethod = method.rawValue
        request.addValue(API.accept.rawValue, forHTTPHeaderField: "Content-Type")
        request.addValue(API.accept.rawValue, forHTTPHeaderField: "Accept")
        call(with: request, completion: completion)
    }
    
    func call<T>(with value: URLRequest, completion: @escaping (Result<T, ApiError>) -> ()) where T : Decodable, T : Encodable {
        let task = URLSession.shared.dataTask(with: value){ (data , response , error) in
            guard let data = data , error == nil else {
                completion(.failure(.serverError))
                return
            }
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            }
            catch(let ex){
                debugPrint("\(ex)")
                completion(.failure(.parseError))
            }
            
        }
        task.resume()
    }
}
