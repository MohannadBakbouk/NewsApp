//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import RxSwift
import RealmSwift

class ArticleListViewModel: ArticleListViewModelProtocol &  ArticleListViewModelEvents {
    
    var inputs : ArticleListViewModelInput {return self}
    
    var outputs : ArticleListViewModelOutput {return self}
    
    var internals: ArticleListViewModelInternal {return self}
    
    var articles: BehaviorSubject<[ArticleViewData]>
    
    var onError: PublishSubject<String>
    
    var isLoading: BehaviorSubject<Bool>
    
    var isLoadingMore : BehaviorSubject<Bool>
    
    var reachedBottomTrigger : PublishSubject<Void>
    
    var writeToLocalDbTrigger: PublishSubject<[Article]>
    
    var loadFromLocalDbTriggerWith : PublishSubject<ApiError>
    
    var onMaximumResultsReachedError : PublishSubject<String>
    
    let disposeBag = DisposeBag()
    
    var apiService : ArticleService
    
    var localStorage : LocalStorage
    
    var currentPage : Int
    
    var pageCount : Int
    
    var pageSize : Int
    
    var query : String
    
    init() {
        isLoading = BehaviorSubject(value: false)
        isLoadingMore = BehaviorSubject(value: false)
        articles = BehaviorSubject(value: [])
        onError = PublishSubject()
        reachedBottomTrigger = PublishSubject()
        writeToLocalDbTrigger = PublishSubject()
        loadFromLocalDbTriggerWith = PublishSubject()
        onMaximumResultsReachedError = PublishSubject()
        apiService = ArticleService()
        localStorage = LocalStorage()
        currentPage = 1
        pageCount = -1
        pageSize = 25
        query = "bitcoin"
        configureReachedBottomTrigger()
        subscribingToWriteToLocalDB()
        subscribingToLoadFromLocalDB()
    }
    
    func loadArticles()  {
        isLoading.onNext(currentPage == 1)
        
        let results =  apiService.searchArticles(query: query, page: currentPage)
        results.subscribe{[weak self] event in
            guard let self = self else { return }
            if let info = event.element , var items = try? self.articles.value()  {
                let newBatch = info.articles.map{ArticleViewData(data: $0)}
                items.append(contentsOf: newBatch)
                self.articles.onNext(items)
                self.isLoadingMore.onNext(false)
                self.isLoading.onNext(false)
                self.pageCount = Int(info.totalResults / self.pageSize)
                let articles = newBatch.map{Article(data: $0)}
                self.internals.writeToLocalDbTrigger.onNext(articles)
            }
            else if let error = event.error  as? ApiError{
                if error != .maximumResultsReached { // that means it fails to load content
                  self.internals.loadFromLocalDbTriggerWith.onNext(error)
                }
                else {
                  self.onMaximumResultsReachedError.onNext(error.message)
                }
            }
        }.disposed(by: disposeBag)
    }
    
    func configureReachedBottomTrigger(){
        reachedBottomTrigger.filter{ [weak self] in
            guard let self = self else { return false}
            return self.currentPage < self.pageCount
        }
        .withLatestFrom(isLoadingMore)
        .filter{$0 == false}
        .subscribe(onNext :{ [weak self] event in
            guard let self = self else { return }
            self.currentPage += 1
            self.isLoadingMore.onNext(true)
            self.loadArticles()
        }).disposed(by: disposeBag)
    }
    
    func subscribingToWriteToLocalDB(){
        internals.writeToLocalDbTrigger.subscribe(onNext :{[weak self] articles in
            guard let self = self else { return }
            print(NSHomeDirectory())
            if self.currentPage == 1 {
                self.localStorage.deleteAll(Article.self)
            }
           self.localStorage.write(articles)
        }).disposed(by: disposeBag)
    }
    
    func subscribingToLoadFromLocalDB(){
        internals.loadFromLocalDbTriggerWith.subscribe(onNext :{[weak self] error in
            guard let self = self else { return }
            print(NSHomeDirectory())
            let articles : [Article] =  self.localStorage.objects()
            if articles.count > 0 {
                let items = articles.map{ArticleViewData(stored: $0)}
                self.articles.onNext(items)
                self.isLoadingMore.onNext(false)
                self.isLoading.onNext(false)
            }
            else {
                self.onError.onNext(error.message)
            }
         
        }).disposed(by: disposeBag)
    }
    
    
    
}
