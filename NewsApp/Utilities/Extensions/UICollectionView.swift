//
//  UICollectionView.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//

import UIKit
import SnapKit

extension UICollectionView {
    func setMessage(_ message : String , icon : String = Icons.sysWifiProblem.rawValue){
        
        let view = UIView()
        self.backgroundView = view
        
        let msgLabel = UILabel()
        msgLabel.textAlignment = .center
        msgLabel.textColor = .lightGray
        msgLabel.numberOfLines = 2
        msgLabel.lineBreakMode = .byTruncatingMiddle
        msgLabel.text = message
        view.addSubview(msgLabel)

        let imgView  = UIImageView()
        imgView.image = UIImage(systemName : icon)!
    
        imgView.tintColor = .lightGray
        imgView.contentMode = .scaleAspectFit
        view.addSubview(imgView)
        
        imgView.snp.makeConstraints { maker in
            maker.width.height.equalTo(50)
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-75)
        }
        
        msgLabel.snp.makeConstraints { maker in
            maker.height.equalTo(60)
            maker.leading.equalTo(view.snp.leading).offset(10)
            maker.trailing.equalTo(view.snp.trailing).offset(-10)
            maker.top.equalTo(imgView.snp.bottom).offset(10)
        }
    }
    
    func setupLoadingIndicator(){
        let indicator = UIActivityIndicatorView()
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .systemRed
        indicator.hidesWhenStopped = true
        backgroundView = indicator
    }
}

