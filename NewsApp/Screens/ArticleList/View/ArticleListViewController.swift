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
    
    var cellHeight = CGFloat(200.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        configureUI()
    }
    
    func configureUI(){
         view.backgroundColor = .white
         navigationItem.title = "Articles"
         configureCollectionView()
         configureCollectionViewConstraints()
         confirgureCollectionCellsSize()
         registerCollectionCell()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: .zero , collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.dataSource = self
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
        let width  = UIScreen.main.bounds.width
        let cellSize = CGSize(width: (CGFloat(width)) , height: cellHeight)
        collectionLayout.itemSize = cellSize
    }
    
    func registerCollectionCell()  {
        collectionView.register(ArticleListItemCell.self, forCellWithReuseIdentifier: Cells.ArticleListItemCell.rawValue)
    }
}


extension ArticleListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.ArticleListItemCell.rawValue, for: indexPath) as! ArticleListItemCell
        return cell
    }
}
