//
//  ArticleDetailsViewControllerTests.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/27/22.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa

@testable import NewsApp
class ArticleDetailsViewControllerTests: XCTestCase {

    var viewController : ArticleDetailsViewController!
    var viewModel : MockArticleDetailsViewModel!
    var scheduler : TestScheduler!
    var disposeBag : DisposeBag!
    var article : ArticleViewData!
    
    override func setUpWithError() throws {
      
        
        article =   MockArticleService.loadFromJsonDirectly()?.first
        viewModel = MockArticleDetailsViewModel(info: article)
        viewController = ArticleDetailsViewController(model: viewModel)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        viewController.loadViewIfNeeded()
        SceneDelegate.shared.window?.rootViewController = viewController
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewController = nil
        scheduler = nil
        disposeBag = nil
    }

    func testArticleTitleIsShown() throws {
        print(viewController.titleLabel.text)
        XCTAssert(viewController.titleLabel.text == article.title , "title isn't shown")
    }
    
    func testArticleDescriptionIsShown() throws{
        XCTAssert(viewController.descriptionTextView.text == article.summery , "Summery isn't shown")
    }
    
    func testArticlePhotoIsShown() throws {
        let exp = expectation(description: "wait unit the image get fetched")
        let waiter = XCTWaiter.wait(for: [exp], timeout: 15)
        if waiter == XCTWaiter.Result.timedOut {
          XCTAssertNotNil(viewController.imgView.image , "the article photo isn't feteched")
        }
        else {
            XCTFail()
        }
    }
    
    func testRateSuccess() throws{
        
        let exp = expectation(description: "assert the alert is shown with the correct message")
        
        scheduler.createColdObservable([.next(0, "3")])
        .bind(to: viewModel.rateValue)
        .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(1, ())])
        .bind(to: viewModel.rateTrigger)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        
        if waiter == XCTWaiter.Result.timedOut {
            XCTAssert(viewController.infoAlert?.messageLab.text == RateStatus.success.rawValue , "the success message isn't displayed")
        }
        else {
            XCTFail()
        }
    }
    
    func testRateInvalidValue() throws {
        
        let exp = expectation(description: "assert the alert")
        
        scheduler.createColdObservable([.next(0, "Mohn")])
        .bind(to: viewModel.rateValue)
        .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(1, ())])
        .bind(to: viewModel.rateTrigger)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        
        if waiter == XCTWaiter.Result.timedOut {
            XCTAssert(viewController.infoAlert?.messageLab.text == RateStatus.invalidValue.rawValue , "the success message isn't displayed")
        }
        else {
            XCTFail()
        }
        
        
    }
    
    
}
