//
//  ArticleListItemCell.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import UIKit

class ArticleListItemCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func configureUI(){
        backgroundColor = .systemGray3
    }
    
    func configureConstraints(){
        
    }
}
