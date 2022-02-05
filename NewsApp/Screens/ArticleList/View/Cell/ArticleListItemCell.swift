//
//  ArticleListItemCell.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import UIKit
import Kingfisher

class ArticleListItemCell: UICollectionViewCell {
    
    var pictureView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.kf.indicatorType = .activity
        img.backgroundColor = .red
        img.layer.cornerRadius = 15
        return img
    }()
    
    var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = "As Kazakhstan Descends into Chaos, Crypto Miners Are at a Loss"
        lab.textColor = .titleColor
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.numberOfLines = 0
        lab.textAlignment = .natural
        return lab
    }()
    
    var publicationLabel : UILabel = {
        let lab = UILabel()
        lab.text = "publicationLabel"
        lab.textColor = .detailsColor
        lab.font = UIFont.boldSystemFont(ofSize: 12)
        return lab
    }()
    
    var publicationIconView  : UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "livephoto")!)
        return img
    }()
    
    lazy var contentStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [ titleLabel , emptyView , footerStack])
       stack.axis = .vertical
       stack.spacing = 10
       stack.distribution = .fill
       return stack
    }()
    
    lazy var footerStack : UIStackView =  {
       let stack = UIStackView(arrangedSubviews: [ publicationIconView , publicationLabel])
       stack.axis = .horizontal
       stack.spacing = 5
       stack.distribution = .fill
       return stack
    }()
    
    var containerView : UIView = {
        let view = UIView()
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    var emptyView : UIView = {
        let view = UIView()
        return view
    }()
    
    
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
        contentView.addSubview(containerView)
        containerView.addSubviews(contentOf: [pictureView ,contentStack])
    }
    
    func configureConstraints(){
        containerView.snp.makeConstraints { maker in
            maker.top.leading.equalTo(contentView).offset(4)
            maker.trailing.bottom.equalTo(contentView).offset(-4)
        }
        contentStack.snp.makeConstraints { maker in
            maker.top.equalTo(pictureView.snp.top).offset(10)
            maker.trailing.equalTo(containerView).offset(-4)
            maker.bottom.equalTo(containerView).offset(-10)
            maker.leading.equalTo(pictureView.snp.trailing).offset(8)
        }
        pictureView.snp.makeConstraints { maker in
            maker.width.equalTo(containerView.snp.width).multipliedBy(0.42)
            maker.height.equalTo(containerView.snp.height).multipliedBy(0.95)
            maker.leading.equalTo(containerView).offset(4)
            maker.centerY.equalTo(containerView.snp.centerY)

        }
        publicationIconView.snp.makeConstraints { maker in
            maker.height.width.equalTo(15)
           
        }
        
    }
}
