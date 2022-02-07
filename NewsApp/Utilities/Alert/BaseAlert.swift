//
//  BaseAlert.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import UIKit

typealias onHidenAction = (() -> Void)

class BaseAlert : UIView {
    
    var onCompletedHideAction : onHidenAction?

    var containerView : UIView = {
         let view = UIView()
         view.layer.cornerRadius = 5
         view.backgroundColor = .alertBg
         return view
    }()
    
    func configureContainerView() {
        frame = UIScreen.main.bounds
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(containerView)
    }
    
    func show(){
        guard let window =  UIApplication.shared.keyWindow else {  return  }
        window.addSubview(self)
        window.bringSubviewToFront(self)
        animateIn()
    }
    
    func hide(){
        animateOut()
    }
    
    @objc func animateIn(){
       alpha = 0
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
           self.alpha = 1
       }, completion: nil)
    }
       
    @objc func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
            self.alpha = 0
        })
        { (completed) in
             if completed {
                self.onCompletedHideAction?()
                self.removeFromSuperview()
            }
       }
    }
}

