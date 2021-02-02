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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keyWordLabel: UILabel!
    
    var viewModel: WebNewsViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("view생성")
        //print(viewModel.url)
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
        
        viewModel.currentNews.bind{
            print($0.description,$0.keyWord)
            self.newsWebView.load(URLRequest(url: URL(string: $0.url)!))
            self.titleLabel.text = "제목 : " + $0.title
            self.keyWordLabel.text = "키워드 : " + $0.keyWord.joined(separator: " / ")
        }
        .disposed(by: disposeBag)
        
    }
    
    
    
}
