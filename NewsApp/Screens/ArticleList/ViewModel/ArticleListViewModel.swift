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
    
    var articles: BehaviorSubject<[ArticleViewData]>
    
    var onError: PublishSubject<String>
    
    var isLoading: BehaviorSubject<Bool>
    
    var isLoadingMore : BehaviorSubject<Bool>
    
    var reachedBottomTrigger : PublishSubject<Void>
    
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
        apiService = ArticleService()
        localStorage = LocalStorage()
        currentPage = 1
        pageCount = -1
        pageSize = 25
        query = "bitcoin"
        configureReachedBottomTrigger()
    }
    
    func loadArticles()  {
        isLoading.onNext(currentPage == 1)
        
        let results =  apiService.searchArticles(query: query, page: currentPage)
        print(NSHomeDirectory())
        results.subscribe{[weak self] event in
            guard let self = self else { return }
            if let info = event.element , var items = try? self.articles.value()  {
                self.pageCount = Int(info.totalResults / self.pageSize)
                items.append(contentsOf: info.articles.map{ArticleViewData(data: $0)})
                self.articles.onNext(items)
                self.isLoadingMore.onNext(false)
                self.isLoading.onNext(false)
                self.pageCount = Int(info.totalResults / self.pageSize)
            }
            else if let error = event.error  as? ApiError{
                self.onError.onNext(error.message)
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
    
    
    
}
