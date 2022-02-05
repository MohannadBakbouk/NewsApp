//
//  Coordinator.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//
import UIKit

protocol Coordinator {
    
    var childCoordinators : [Coordinator] {get set}
    
    var navigationController : UINavigationController {get set}
    
    func start()
    
    func back()
}
