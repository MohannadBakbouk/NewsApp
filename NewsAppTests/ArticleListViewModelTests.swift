//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/5/22.
//

import XCTest
import RxSwift
import RxTest
@testable import NewsApp

class ArticleListViewModelTests : XCTestCase {
    
    var viewModel : ArticleListViewModel!
    var scheduler : TestScheduler!
    var disposeBag : DisposeBag!
    
    override func setUpWithError() throws {
        viewModel = ArticleListViewModel(api: MockArticleService(), localDb: MockLocalStorage())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
        scheduler = nil
    }

    func testFetchingArticlesFromApi() throws {
        let articles = scheduler.createObserver([ArticleViewData].self)

         viewModel.outputs.articles
        .bind(to: articles)
        .disposed(by: disposeBag)
        
        viewModel.loadArticles()
        
        XCTAssert(articles.events.count == 2 , "Failed to fetch artilces from api")
    }
    
    func testIsLoadingIndicator(){
        let isLoading = scheduler.createObserver(Bool.self)
        
        viewModel.outputs.isLoading
       .bind(to: isLoading)
       .disposed(by: disposeBag)
        
        XCTAssertRecordedElements(isLoading.events, [false])
        
        viewModel.loadArticles()
        
        XCTAssertRecordedElements(isLoading.events, [false , true , false])
    }
    
    func testErrorWhileFetchingArticlesFromApi(){
        let errorObserver = scheduler.createObserver(String.self)
        
        viewModel.outputs.onError
        .bind(to: errorObserver)
        .disposed(by: disposeBag)
        
        viewModel.internals.rawArticles.onError(ApiError.internetOffline)
        
        XCTAssertEqual(errorObserver.events.last?.value.element , ApiError.internetOffline.message)
    }
    
    func testMaximumResultError(){
        let maximumError = scheduler.createObserver(String.self)
        
        viewModel.outputs.onMaximumResultsReachedError
        .bind(to: maximumError)
        .disposed(by: disposeBag)
        
        viewModel.internals.rawArticles.onError(ApiError.maximumResultsReached)
        
        XCTAssertEqual(maximumError.events.last?.value.element, ApiError.maximumResultsReached.message)
    }
    
    func testDidWriteToDb() throws {
        
        viewModel.loadArticles()
        
        let storedItems : [Article] =  viewModel.localStorage.objects()
        
        XCTAssert(storedItems.count == 2 , "Didn't write the artilces to local DB ")
        
    }
    
    func testDidLoadFromDb(){
        let articles = scheduler.createObserver([ArticleViewData].self)
        
        viewModel.outputs.articles
        .bind(to: articles)
        .disposed(by: disposeBag)
        
        /* load value to db */
        (viewModel.localStorage as? MockLocalStorage)?.loadDummyJsonToDB()
        
        viewModel.internals.rawArticles.onError(ApiError.internalError)
        
        XCTAssert(articles.events.count == 2 , "Fail to load the artilces from DB")
    }
}
