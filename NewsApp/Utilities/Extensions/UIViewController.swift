//
//  UIViewController.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import UIKit

extension UIViewController
{
    class func instantiateFromStoryboard(_ name: String = "Main") -> Self{
        return instantiateFromStoryboardHelper(name)
    }

    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T{
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}

