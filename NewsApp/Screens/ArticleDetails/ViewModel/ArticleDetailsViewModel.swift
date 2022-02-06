//
//  ArticleDetailsViewModel.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import RxSwift

class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol , ArticleDetailsViewModelEvents {
    
    var inputs: ArticleDetailsViewModelInput {self}
    
    var outputs: ArticleDetailsViewModelOutput {self}
    
    var rateTrigger: PublishSubject<Void>
    
    var article: BehaviorSubject<ArticleViewData>
    
    let disposeBag = DisposeBag()
    
    init(article : ArticleViewData) {
        self.article = BehaviorSubject(value: article)
        rateTrigger = PublishSubject()
    }
    
    
}
