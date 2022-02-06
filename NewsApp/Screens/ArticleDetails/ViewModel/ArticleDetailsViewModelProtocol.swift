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
}

protocol ArticleDetailsViewModelOutput {
    var article : BehaviorSubject<ArticleViewData> {get}
}

protocol ArticleDetailsViewModelProtocol {
    var inputs : ArticleDetailsViewModelInput {get}
    var outputs : ArticleDetailsViewModelOutput {get}
}
