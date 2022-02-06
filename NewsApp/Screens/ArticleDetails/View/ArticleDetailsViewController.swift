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
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var titleLabel: PaddingUILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var rateTextField: UITextField!
    
    
    @IBOutlet weak var rateButton: UIButton!
    let disposeBag  = DisposeBag()
    
    var viewModel : ArticleDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIBinding()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureUIBinding(){
        bindingArticleInfoToUI()
        subscriptingToRateButton()
        subscriptingToRateTextField()
        subscribingToRateResult()
    }
    
}
