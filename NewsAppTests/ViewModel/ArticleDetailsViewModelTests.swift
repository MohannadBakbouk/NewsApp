//
//  ArticleDetailsModelTests.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/27/22.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa

@testable import NewsApp
class ArticleDetailsViewodelTests: XCTestCase {

    var viewModel : ArticleDetailsViewModel!
    var disposeBag : DisposeBag!
    var schdeuler : TestScheduler!
    var article : ArticleViewData!
    
    override func setUpWithError() throws {
       
        article =   MockArticleService.loadFromJsonDirectly()?.first
        viewModel = ArticleDetailsViewModel(article: article)
        disposeBag = DisposeBag()
        schdeuler = TestScheduler(initialClock: 0)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
        schdeuler = nil
    }

    func testArticleDetailsIsPublished() throws {
        let articleOut = schdeuler.createObserver(ArticleViewData.self)
        
        viewModel.outputs.article
        .bind(to: articleOut)
        .disposed(by: disposeBag)
        
        XCTAssert(articleOut.events.count == 1)
    }
    
    func test_isProcessingRate(){
        let isProcessing = schdeuler.createObserver(Void.self)
        
        viewModel.outputs.processingRate
        .bind(to: isProcessing)
        .disposed(by: disposeBag)
        
        schdeuler.createColdObservable([.next(0, ())])
        .bind(to: viewModel.inputs.rateTrigger)
        .disposed(by: disposeBag)
        
        schdeuler.start()
        
        XCTAssertNotNil(isProcessing.events.first , "is Processing rate action")
    }
    
    func test_rateSuccess(){
        let rateStatus = schdeuler.createObserver(RateStatus.self)
        
        let exp = expectation(description: "wait unit the rate value to be processed")
        
        viewModel.outputs.rateResult
        .bind(to: rateStatus)
        .disposed(by: disposeBag)
        
        schdeuler.createColdObservable([.next(0, "3")])
        .bind(to: viewModel.inputs.rateValue)
        .disposed(by: disposeBag)
        
        schdeuler.createColdObservable([.next(2, ())])
        .bind(to: viewModel.inputs.rateTrigger)
        .disposed(by: disposeBag)
        
        schdeuler.start()
        
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        
        if waiter == XCTWaiter.Result.timedOut   {
        
           XCTAssert(rateStatus.events.first?.value.element == RateStatus.success , "rate operation was failed")
        }
        else {
           XCTFail("rate operation was failed")
        }
    }
    
    func test_rateIsOutOfAllowedRange()  {
     
        let status = schdeuler.createObserver(RateStatus.self)
        
        let exp = expectation(description: "rate fails")
        
        viewModel.outputs.rateResult
        .bind(to: status)
        .disposed(by: disposeBag)
        
        schdeuler.createColdObservable([.next(0,   "8")])
        .bind(to: viewModel.inputs.rateValue)
        .disposed(by: disposeBag)
        
        schdeuler.createColdObservable([.next(2, ())])
        .bind(to: viewModel.inputs.rateTrigger)
        .disposed(by: disposeBag)
        
        schdeuler.start()
        
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        
        if  waiter == XCTWaiter.Result.timedOut {
            XCTAssert(status.events.first?.value.element == RateStatus.invalidRange , "checking rate value is within the range")
        }
        else {
            XCTFail()
        }
    }
}
