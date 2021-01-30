//
//  WebNewsViewController.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/30.
//

import UIKit
import RxCocoa
import RxSwift
import WebKit

class WebNewsViewController: UIViewController, ViewModelBindableType{

    @IBOutlet weak var newsWebView: WKWebView!
    var viewModel: WebNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        
    }

  

}
