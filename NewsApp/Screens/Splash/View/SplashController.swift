//
//  ViewController.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import UIKit
import MaterialComponents
import SnapKit

class SplashController: UIViewController {
    
    weak var coordinator : MainCoordinator?
    
    var inidicatorView :  MDCActivityIndicator = {
        let item = MDCActivityIndicator()
        item.tintColor = .systemRed
        item.radius = 20
        item.cycleColors = [.systemRed]
        return item
    }()
    
    var slugLabel : UILabel = {
        let lab = UILabel()
        lab.text = "News App"
        lab.textColor = .systemRed
        lab.font = UIFont.boldSystemFont(ofSize: 25)
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        routeToNextScreen()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [slugLabel , inidicatorView])
        congifureUIConstrains()
    }
    
    func congifureUIConstrains(){
        
        slugLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-50)

        }
        
        inidicatorView.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.centerX.equalTo(self.view)
        }
    }
    
    func routeToNextScreen()  {
        inidicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.coordinator?.showArticles()
        }
    }
    

}

