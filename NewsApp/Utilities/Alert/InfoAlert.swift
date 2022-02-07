//
//  InfoAlert.swift
//  NewsApp
//
//  Created by Mohannad on 2/7/22.
//

import UIKit

class InfoAlert : BaseAlert {

    var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textAlignment = .center
        lab.numberOfLines = 1
        lab.textColor = .white
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    var messageLab : UILabel = {
         let lab = UILabel()
         lab.text = ""
         lab.textAlignment = .center
         lab.numberOfLines = 3
         lab.textColor = .white
         lab.setContentHuggingPriority(.defaultLow, for: .vertical)
         return lab
     }()
    
    var iconImageView : UIImageView = {
         let img = UIImageView()
        img.image = UIImage(systemName: Icons.infoAlert.rawValue )?.withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
         return img
    }()
    
    var separatorView : UIView = {
      let view = UIView()
      view.backgroundColor = .white
      return view
    }()
    
    var okButton : UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        configureContainerView()
        containerView.addSubviews(contentOf: [iconImageView, titleLabel, messageLab, separatorView, okButton])
       /* containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLab)
        containerView.addSubview(separatorView)
        containerView.addSubview(okButton)*/
        configureUIConstrains()
        configureUIEvents()
    }
    
    func configureUIConstrains(){
        containerView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.width.equalTo(self.snp.width).multipliedBy(0.8)
            maker.height.equalTo(self.snp.height).multipliedBy(0.28)
            maker.centerX.centerY.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.width.height.equalTo(45)
            maker.centerX.equalTo(self.containerView.snp.centerX)
            maker.top.equalTo(self.containerView.snp.top).offset(10)
        }
        
        titleLabel.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.height.equalTo(30)
            maker.centerX.equalTo(self.containerView)
            maker.top.equalTo(self.iconImageView.snp.bottom).offset(5)
        }
        
        messageLab.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.leading.equalTo(self.containerView).offset(10)
            maker.trailing.equalTo(self.containerView).offset(-10)
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
        
        separatorView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.height.equalTo(2)
            maker.leading.trailing.equalTo(self.containerView)
            maker.top.equalTo(self.messageLab.snp.bottom).offset(10)
        
        }
        
        okButton.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.height.equalTo(30)
            maker.width.equalTo(self.containerView)
            maker.top.equalTo(self.separatorView.snp.bottom).offset(5)
            maker.bottom.equalTo(self.containerView.snp.bottom).offset(-5)
        }
    }
    
    func configureUIEvents(){
        okButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
    }
    
    func show(title : String = "Info" , message : String = "Something Went Wrong")  {
        titleLabel.text = title
        messageLab.text = message
        super.show()
    }
    

}

