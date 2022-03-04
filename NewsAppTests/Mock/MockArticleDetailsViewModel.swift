//
//  MockArticleDetailsViewModel.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/27/22.
//

import Foundation
import RxSwift

@testable import NewsApp

class MockArticleDetailsViewModel : ArticleDetailsViewModelEvents , ArticleDetailsViewModelProtocol {
    
    var rateTrigger: PublishSubject<Void>
    
    var rateValue: BehaviorSubject<String>
    
    var article: BehaviorSubject<ArticleViewData>
    
    var rateResult: PublishSubject<RateStatus>
    
    var processingRate: PublishSubject<Void>
    
    var inputs: ArticleDetailsViewModelInput { self}
    
    var outputs: ArticleDetailsViewModelOutput { self}
    
    var disposeBag : DisposeBag!
    
    init(info : ArticleViewData) {
        article = BehaviorSubject(value: info)
        rateValue = BehaviorSubject(value: "")
        rateTrigger = PublishSubject()
        rateResult = PublishSubject()
        processingRate = PublishSubject()
        disposeBag = DisposeBag()
        subscribingToRateValue()
    }
    //ask about
    func subscribingToRateValue(){
        rateTrigger.subscribe(onNext : {[weak self] item in
            guard let self = self else {return}
            self.processingRate.onNext(())
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                if let userRate = try? self.rateValue.value()   {
                    let result : RateStatus = (userRate.isNumber && (1...5).contains(userRate.toInt)) ? .success :
                                 (userRate.isNumber && !(1...5).contains(userRate.toInt)) ? .invalidRange : .invalidValue
                    self.rateResult.onNext(result)
                }
                else {
                    self.rateResult.onNext(.invalidValue)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    
}

