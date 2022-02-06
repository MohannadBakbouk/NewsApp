//
//  ArticleDetailsViewModelProtocol.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import RxSwift

typealias ArticleDetailsViewModelEvents = ArticleDetailsViewModelInput & ArticleDetailsViewModelOutput

protocol ArticleDetailsViewModelInput {
    var rateTrigger : PublishSubject<Void> {get}
    var rateValue : BehaviorSubject<String> {get}
}

protocol ArticleDetailsViewModelOutput {
    var article : BehaviorSubject<ArticleViewData> {get}
    var rateResult : PublishSubject<RateStatus> {get}
}

protocol ArticleDetailsViewModelProtocol {
    var inputs : ArticleDetailsViewModelInput {get}
    var outputs : ArticleDetailsViewModelOutput {get}
}
