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
    
    func subscribingToRateTextField(){
        rateTextField.rx.controlEvent(.editingChanged)
        .withLatestFrom(rateTextField.rx.text.orEmpty)
        .bind(to: viewModel.inputs.rateValue)
        .disposed(by: disposeBag)
    }
    
    func subscribingToRateButton(){
        rateButton.rx.tap
        .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
        .bind(to: viewModel.inputs.rateTrigger)
        .disposed(by: disposeBag)
        
    }
    
    func subscribingToProcessingRate(){
        viewModel.outputs.processingRate
        .subscribe(onNext: { [weak self] item in
            DispatchQueue.main.async{
              self?.configureIndicatorAlert()
              self?.indicatorAlert?.show()
            }
        }).disposed(by: disposeBag)
    }
    
    func subscribingToRateResult(){
         viewModel.outputs.rateResult
        .subscribe(onNext : { [weak self] item in
            DispatchQueue.main.async {
                self?.indicatorAlert?.hide()
                self?.configureInfoAlert()
                self?.infoAlert?.show(message: item.rawValue)
            }
        })
       .disposed(by: disposeBag)
    }
}
