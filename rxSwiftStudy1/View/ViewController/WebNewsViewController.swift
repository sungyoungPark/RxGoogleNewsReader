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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view생성")
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        /* //백버튼을 교체하는 형식 
         //타이틀이 drive 형식으로 전달되기 때문에 생성자로는 전달 할 수 없다.
         var backBTN = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
         
         viewModel.title.drive(backBTN.rx.title)
         .disposed(by: disposeBag )
         
         backBTN.rx.action = viewModel.popAction
         
         //back 버튼을 대체하는 코드는 이전 뷰컨트롤러에서 구현하고, left나 right bar button을 설정하는 코드는 해당 뷰 컨트롤러에서 규현해야 한다.
         navigationItem.hidesBackButton = true
         navigationItem.leftBarButtonItem = backBTN
         */
    }
    
    
    
}
