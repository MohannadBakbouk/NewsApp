//
//  ArticleListViewController+Binding.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import RxSwift
import RxCocoa

extension ArticleListViewController {
    
    func bindingCollectionViewDataSource(){
        viewModel.outputs.articles.bind(to: collectionView.rx.items){ (collection , index , item) in
            let index = IndexPath(row: index, section: 0)
            let cell = collection.dequeueReusableCell(withReuseIdentifier: Cells.articleListItemCell.rawValue, for: index) as! ArticleListItemCell
            cell.setup(with: item)
            return cell
        }.disposed(by: disposeBag)
    }
    
    func bindingSelectCollectionViewItem(){
        collectionView.rx.modelSelected(ArticleViewData.self)
        .subscribe(onNext : { [weak self] item in
            guard let self = self else {return}
            self.coordinator?.showArticleDetails(with: item)
        }).disposed(by: disposeBag)
    }
    
    func bindingCollectionViewScrolling(){
        collectionView.rx.reachedBottom.asObservable()
            .bind(to: viewModel.inputs.reachedBottomTrigger)
        .disposed(by: disposeBag)
    }
    
    func bindindCollectionViewLoadingIndicator()  {
        collectionView.setupLoadingIndicator()
        guard  let indicator = collectionView.backgroundView as? UIActivityIndicatorView else {
            return
        }
        viewModel.outputs.isLoading
        .bind(to: indicator.rx.isAnimating)
        .disposed(by: disposeBag)
    }
    
    func bindingLoadingError(){
        viewModel.outputs.onError
        .observe(on: MainScheduler.asyncInstance)
        .subscribe(onNext : { [weak self] error in
            self?.collectionView.setMessage(error)
        }).disposed(by: disposeBag)
    }
}
