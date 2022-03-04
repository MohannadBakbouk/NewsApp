//
//  MockArticleListViewModel.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/20/22.
//

import Foundation
import RxSwift

@testable import NewsApp

class MockArticleListViewModel: ArticleListViewModelEvents & ArticleListViewModelProtocol {
    
    var reachedBottomTrigger: PublishSubject<Void>
    
    var writeToLocalDbTrigger: PublishSubject<[Article]>
    
    var loadFromLocalDbTriggerWith: PublishSubject<ApiError>
    
    var rawArticles: PublishSubject<SearchArticlesResponse>
    
    var articles: BehaviorSubject<[ArticleViewData]>
    
    var isLoading: BehaviorSubject<Bool>
    
    var isLoadingMore: BehaviorSubject<Bool>
    
    var onError: PublishSubject<String>
    
    var onMaximumResultsReachedError: PublishSubject<String>
    
    var inputs: ArticleListViewModelInput {return self}
    
    var outputs: ArticleListViewModelOutput  {return self}
    
    var internals: ArticleListViewModelInternal {return self}
    
    //* */
    var apiService : ArticleServiceProtocol
    
    var localStorage : LocalStorageProtocol
    
    
    init() {
        isLoading = BehaviorSubject(value: false)
        isLoadingMore = BehaviorSubject(value: false)
        articles = BehaviorSubject(value: [])
        rawArticles = PublishSubject()
        onError = PublishSubject()
        reachedBottomTrigger = PublishSubject()
        writeToLocalDbTrigger = PublishSubject()
        loadFromLocalDbTriggerWith = PublishSubject()
        onMaximumResultsReachedError = PublishSubject()
        apiService = MockArticleService()
        localStorage = MockLocalStorage()
    }
    
    func loadArticles() {
        
    }
    
    func configureReachedBottomTrigger() {
        
    }
    
    
}

extension MockArticleListViewModel {
    
    func loadDummyJsonFromFile() -> [ArticleViewData]?{
        
        guard let data = try? Data(contentsOf: Bundle.main.url(forResource: "MockedArticleResponse", withExtension: "json")!) ,
        
        let response =  try? JSONDecoder().decode(SearchArticlesResponse.self, from: data) else { return  nil}
        
        let dummyArticles = response.articles.map{ArticleViewData(data: $0)}
        
        
        return dummyArticles
        
        
    }
}

