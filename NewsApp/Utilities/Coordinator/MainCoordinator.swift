//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigation : UINavigationController) {
        self.navigationController = navigation
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func start() {
        let splash = SplashController() //.instantiateFromStoryboard()
        splash.coordinator = self
        pushViewControllerToStack(with: splash)
    }
    
    func showArticles(){
        let main = ArticleListViewController() //viewModel: ArticleListViewModel()
        main.coordinator = self
        pushViewControllerToStack(with: main)
    }
    
    func showArticleDetails(with info : ArticleViewData){
        let articleDetails = ArticleDetailsViewController()
        let model = ArticleDetailsViewModel(article: info)
        articleDetails.viewModel = model
        navigationController.navigationBar.isHidden = false
        pushViewControllerToStack(with: articleDetails)
    }
    
    func pushViewControllerToStack(with value : UIViewController , animated : Bool = true , isRoot : Bool = false){
        
        if  isRoot {
            navigationController.viewControllers = []
        }
        navigationController.pushViewController(value, animated: animated)
    }
    
}
