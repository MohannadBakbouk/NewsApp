//
//  View.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

import UIKit

extension UIView {
    func addSubviews(contentOf views : [UIView]) {
        for item in views {
          addSubview(item)
        }
    }
}
