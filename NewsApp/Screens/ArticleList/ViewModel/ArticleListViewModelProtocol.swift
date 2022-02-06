//
//  ArticleListViewModelProtocol.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import RxSwift

typealias  ArticleListViewModelEvents = ArticleListViewModelInput & ArticleListViewModelOutput

protocol ArticleListViewModelOutput  {
    
    var articles : BehaviorSubject<[ArticleViewData]> {get}
    
    var isLoading : BehaviorSubject<Bool> {get}
    
    var isLoadingMore : BehaviorSubject<Bool> {get}

    var onError : PublishSubject<String> {get}
}

protocol ArticleListViewModelInput {
 
    var reachedBottomTrigger : PublishSubject<Void>{get}
}


protocol ArticleListViewModelProtocol {
    
    var inputs : ArticleListViewModelInput {get}
    
    var outputs : ArticleListViewModelOutput {get}
    
    func loadArticles()
    
    func configureReachedBottomTrigger()
}
