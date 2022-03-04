//
//  MockArticleService.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/9/22.
//

import Foundation
import RxSwift

@testable import NewsApp
class MockArticleService : ArticleServiceProtocol {
    func searchArticles(query: String, page: Int, pageSize: Int) -> Observable<SearchArticlesResponse> {
        return Observable.create { observable in
            
            let data = try? Data(contentsOf: Bundle.main.url(forResource: "MockedArticleResponse", withExtension: "json")!)
            
            let dummyResponse =  try! JSONDecoder().decode(SearchArticlesResponse.self, from: data!)
            
            observable.onNext(dummyResponse)
            
            return Disposables.create()
        }
    }
}

extension MockArticleService {
    
  class func loadFromJsonDirectly() -> [ArticleViewData]?{
      
        guard let data = try? Data(contentsOf: Bundle.main.url(forResource: "MockedArticleResponse", withExtension: "json")!) ,
        
        let response =  try? JSONDecoder().decode(SearchArticlesResponse.self, from: data)
        else { return  nil}
        
        return response.articles.map{ArticleViewData(data: $0)}
    
        

    }
}
