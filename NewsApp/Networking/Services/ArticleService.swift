//
//  ArticleService.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import RxSwift

protocol ArticleServiceProtocol {
    func searchArticles(query : String , page : Int , pageSize : Int) -> Observable<SearchArticlesResponse>
}

class ArticleService : ArticleServiceProtocol {
    
    var api : APIManagerProtocol!
    
    init(api : APIManagerProtocol = APIManager()) {
        self.api = api
    }
    
    func searchArticles(query: String, page: Int, pageSize : Int = 25) -> Observable<SearchArticlesResponse> {
        let params : [String : Any]  = ["q" : query ,"apiKey" : API.key.rawValue , "pageSize" : pageSize , "page" : page]
        return Observable.create { observable in
            
            self.api.request(endpoint: .serachArticles, method: .Get, params: params) { (response : Result<SearchArticlesResponse, ApiError>) in
                if  case .success(let data) = response , data.status == "ok"{
                    debugPrint(data.articles.count)
                    debugPrint(data.articles.count)
                    observable.onNext(data)
                }
                else if  case .success(let data) = response , data.status == "error" , data.code == String(describing: ApiError.maximumResultsReached) {
                    observable.onError(ApiError.maximumResultsReached)
                }
                else if case .failure(let ex) = response{
                    observable.onError(ex)
                }
            }
            return Disposables.create()
        }
    }
    
    
}



