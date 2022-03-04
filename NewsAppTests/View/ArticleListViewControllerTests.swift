//
//  ArticleListViewController.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/20/22.
//

import XCTest
import RxSwift
import RxTest
import RxCocoa

@testable import NewsApp
class ArticleListViewControllerTests: XCTestCase {
    var viewController : ArticleListViewController!
    var viewModel : MockArticleListViewModel!
    var scheduler : TestScheduler!
    var disposeBag : DisposeBag!
    var window: UIWindow?

    override func setUpWithError() throws {
        
       viewModel = MockArticleListViewModel()
       viewController = ArticleListViewController(viewModel: viewModel)
       scheduler = TestScheduler(initialClock: 0)
       disposeBag = DisposeBag()
       viewController.loadViewIfNeeded()
        /*let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            sceneDelegate.window!.rootViewController = viewController*/
        // without this some views some be dispalyed
        SceneDelegate.shared.window?.rootViewController = viewController
    
    }

    override func tearDownWithError() throws {
        viewModel = nil
        scheduler = nil
        disposeBag = nil
    }

    func testLoadingIndicatorIsShown() throws {
        
        viewController.loadViewIfNeeded()
        
        scheduler.createColdObservable([.next(0, true)])
        .bind(to: viewModel.outputs.isLoading)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        let indicator = viewController.collectionView.backgroundView as? UIActivityIndicatorView
        
        XCTAssertNotNil(indicator ,"Indicator isn't shown")
    }
    
    func testLoadingIndicatorIsAnimating(){
     
        viewController.loadViewIfNeeded()
        
        scheduler.createColdObservable([.next(0 , true)])
        .bind(to: viewModel.outputs.isLoading)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        guard  let indicator = viewController.collectionView.backgroundView as? UIActivityIndicatorView else {
            XCTAssert(false)
            return
        }
        XCTAssertTrue(indicator.isAnimating , "the loading indicator isn't animating")
    
    }
    
    func testArticleListAreShown(){
         viewController.loadViewIfNeeded()
      
         let articles = viewModel.loadDummyJsonFromFile()
            
          scheduler.createColdObservable([.next(0, articles!)])
         .bind(to: viewModel.outputs.articles)
         .disposed(by: disposeBag)
        
         scheduler.start()
        
        print(viewController.collectionView.numberOfItems(inSection: 0) )
        
        let exp = expectation(description: "collection is displaying new articles")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            print(viewController.collectionView.indexPathsForVisibleItems.count) // 2
            print(viewController.collectionView.visibleCells.count) // 2
            XCTAssert(viewController.collectionView.indexPathsForVisibleItems.count > 0 , "the collection isn't displaying any articles")
        }
        else {
            XCTFail()
        }
    }
    
    func test_InternetConnectionError(){
    
        let exp = expectation(description: "an error has raised")
        
        scheduler.createColdObservable([.next(0, ApiError.internetOffline.message)])
        .bind(to: viewModel.outputs.onError)
        .disposed(by : disposeBag)
        scheduler.start()
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            guard let container = viewController.collectionView.backgroundView ,
                  let msglabel = container.subviews.first as? UILabel else {
                XCTFail("Error message is mismatched")
                return
            }
            print(container.subviews.count)
            XCTAssert( msglabel.text == ApiError.internetOffline.message)
        }
        else {
            XCTFail()
        }
    }
    
    func test_maximumResultMessageIsShown(){
     
        let exp = expectation(description: "Maximum Results")
        
        let expectedMessage = ApiError.maximumResultsReached.message
        
        scheduler.createColdObservable([.next(0, ApiError.maximumResultsReached.message)])
        .bind(to: viewModel.onMaximumResultsReachedError)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        
        if   waiter == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(viewController.infoAlert)
            XCTAssert(viewController.infoAlert?.messageLab.text == expectedMessage , "the maximum result message is shown")
        }
        else {
            XCTFail("the maximum result message is shown")
        }
    }
}
