//
//  ArticleDetailsViewModel.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import RxSwift

class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol , ArticleDetailsViewModelEvents {
    
    var inputs : ArticleDetailsViewModelInput {self}
    
    var outputs : ArticleDetailsViewModelOutput {self}
    
    var rateTrigger : PublishSubject<Void>
    
    var rateValue : BehaviorSubject<String>
    
    var article: BehaviorSubject<ArticleViewData>
    
    var rateResult: PublishSubject<RateStatus>
    
    let disposeBag = DisposeBag()
    
    init(article : ArticleViewData) {
        self.article = BehaviorSubject(value: article)
        rateValue = BehaviorSubject(value: "")
        rateTrigger = PublishSubject()
        rateResult = PublishSubject()
        subscribingToRateValue()
    }
    
    func subscribingToRateValue(){
        rateTrigger.subscribe(onNext : {[weak self] item in
            guard let self = self else {return}
            if let userRate = try? self.rateValue.value()   {
                let result : RateStatus = (userRate.isNumber && (1...5).contains(userRate.toInt)) ? .success :
                             (userRate.isNumber && !(1...5).contains(userRate.toInt)) ? .invalidRange : .invalidValue
                self.rateResult.onNext(result)
            }
            else {
                self.rateResult.onNext(.invalidValue)
            }
        }).disposed(by: disposeBag)
    }
    
   
    
    
}

