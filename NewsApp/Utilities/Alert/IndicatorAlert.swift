//
//  IndicatorAlert.swift
//  NewsApp
//
//  Created by Mohannad on 2/7/22.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class IndicatorAlert : BaseAlert {

    var activityInidicatorView :  MDCActivityIndicator = {
        let item = MDCActivityIndicator()
        item.tintColor = .white
        item.radius = 20
        item.cycleColors = [.white]
        return item
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
        containerView.addSubview(activityInidicatorView)
        configureUIConstrains()
    }
    
    func configureUIConstrains(){
        containerView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.width.equalTo(self.snp.width).multipliedBy(0.2)
            maker.height.equalTo(self.snp.height).multipliedBy(0.08)
            maker.centerX.centerY.equalTo(self)
        }
        
        activityInidicatorView.snp.makeConstraints {[weak self] maker in
            guard let self = self else { return }
            maker.centerX.centerY.equalTo(self.containerView)
        }
    }
    
    override func show() {
        super.show()
        activityInidicatorView.startAnimating()
    }
    
    override func hide() {
        super.hide()
        activityInidicatorView.stopAnimating()
    }
}

