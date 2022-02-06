//
//  ArticleDetailsViewController+BindingModel.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import RxSwift

extension ArticleDetailsViewController {
    
    func bindingArticleInfoToUI(){
        viewModel.outputs.article
        .subscribe(onNext : {[weak self] item in
            guard let self = self else {return}
            self.contentTextView.text = item.content
            self.descriptionTextView.text = item.summery
            self.titleLabel.text = item.title
            if let url = URL(string: item.img) {
              self.imgView.kf.setImage(with: url)
            }
        }).disposed(by: disposeBag)
    }
}
