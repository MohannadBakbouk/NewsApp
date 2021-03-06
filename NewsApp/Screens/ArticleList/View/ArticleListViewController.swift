//
//  ArticleListViewController.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import UIKit
import RxSwift

class ArticleListViewController: UIViewController {

    weak var coordinator : MainCoordinator?
    
    var collectionView : UICollectionView!
    
    var  collectionLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    let disposeBag  = DisposeBag()
    
    var infoAlert : InfoAlert?
    
    var viewModel : ArticleListViewModelProtocol!
    
    var cellHeight = CGFloat(150)
    
    init(viewModel: ArticleListViewModelProtocol = ArticleListViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(* , unavailable)
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.viewModel = ArticleListViewModel()
        configureUI()
        configureUIBinding()
        viewModel.loadArticles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        infoAlert = nil
    }
    
    func configureUI(){
         view.backgroundColor = .white
         navigationItem.title = "Articles"
         configureCollectionView()
         configureCollectionViewConstraints()
         confirgureCollectionCellsSize()
         registerCollectionCell()
    }
    
    func configureUIBinding(){
        bindingCollectionViewDataSource()
        bindingCollectionViewScrolling()
        bindingSelectCollectionViewItem()
        bindindCollectionViewLoadingIndicator()
        bindingLoadingError()
        bindingMaximumResultsReachedError()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero , collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    func configureCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.snp.makeConstraints { maker in
            maker.leading.equalTo(view.snp.leading).offset(10)
            maker.trailing.equalTo(view.snp.trailing).offset(-10)
            maker.bottom.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
    
    func confirgureCollectionCellsSize(){
        let width  = UIScreen.main.bounds.width - 20
        let cellSize = CGSize(width: (CGFloat(width)) , height: cellHeight)
        collectionLayout.itemSize = cellSize
    }
    
    func registerCollectionCell()  {
        collectionView.register(ArticleListItemCell.self, forCellWithReuseIdentifier: Cells.articleListItemCell.rawValue)
    }
    
    func configureInfoAlert(){
        self.infoAlert = InfoAlert()
        self.infoAlert?.onCompletedHideAction = { [weak self] in
            self?.infoAlert = nil
        }
    }
}
