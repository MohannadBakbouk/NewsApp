//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Mohannad on 2/6/22.
//
import UIKit
import RxSwift

class ArticleDetailsViewController: UIViewController {
    
    var infoAlert : InfoAlert?
    
    var indicatorAlert : IndicatorAlert?

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var titleLabel: PaddingUILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var rateTextField: UITextField!
    
    @IBOutlet weak var rateButton: UIButton!
    
    let disposeBag  = DisposeBag()
    
    var viewModel : ArticleDetailsViewModelProtocol!
    
    convenience init(model : ArticleDetailsViewModelProtocol ){
        self.init()
        viewModel = model  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIBinding()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        indicatorAlert = nil
        infoAlert = nil
    }
    
    func configureUIBinding(){
        bindingArticleInfoToUI()
        subscribingToRateButton()
        subscribingToRateTextField()
        subscribingToRateResult()
        subscribingToProcessingRate()
    }
    
    func configureInfoAlert(){
        self.infoAlert = InfoAlert()
        self.infoAlert?.onCompletedHideAction = { [weak self] in
            self?.infoAlert = nil
        }
    }
    
    func configureIndicatorAlert(){
        indicatorAlert = IndicatorAlert()
        self.indicatorAlert?.onCompletedHideAction = { [weak self] in
            self?.indicatorAlert = nil
        }
    }
    
}
