//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustTextViewsHeight()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func adjustTextViewsHeight(){
        descriptionTextView.sizeToFit()
        descriptionHeight.constant = descriptionTextView.frame.height + 25
        contentTextView.sizeToFit()
        contentHeight.constant = contentTextView.frame.height + 25
    }
    
}
