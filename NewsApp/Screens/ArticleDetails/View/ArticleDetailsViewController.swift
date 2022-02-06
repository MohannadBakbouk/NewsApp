//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import UIKit
import RxSwift

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: PaddingUILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    let disposeBag  = DisposeBag()
    
    var viewModel : ArticleDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingArticleInfoToUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    

}
