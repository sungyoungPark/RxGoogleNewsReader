//
//  ViewController.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/22.
//

import UIKit
import RxCocoa
import RxSwift

class FirstViewController: UIViewController, ViewModelBindableType  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: FirstViewModel!
    
    //var shownCities = [String]()
    //let allCities = ["New York","London","Oslo","Warsaw","Seoul","Tokyo","GoYang","Praga","Berlin"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        /*
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.rx.text //RxCocoa의 Observable 속성
            .orEmpty //옵셔널이 아니도록 만든다.
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)  //0.5초 기다린다.
            .distinctUntilChanged()  //새로운 값이 이전의 값과 같은지 확인
            .filter{ !$0.isEmpty } //새로운 값이 들어왔고, 비어있는 쿼리는 필터링
            .subscribe(onNext: { [unowned self] query in
            self.shownCities = self.allCities.filter{ $0.hasPrefix(query)}
            self.tableView.reloadData() //테이블 뷰를 다시 불러옴
        })
        .disposed(by: disposeBag)
        */
    }
    
    func bindViewModel() {
        
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "newsCell")){
                (index: Int, element: News, cell: NewsTableViewCell) in
                print("bind",element.title,element.description)
                cell.newsTitle.text = element.title
                cell.newsDescription.text = element.description

            }
            .disposed(by: disposeBag)
        
        /*
        viewModel.cityList
            .bind(to: tableView.rx.items(cellIdentifier: "newsCell")) {
                (index: Int, element: News, cell: NewsTableViewCell) in
                cell.newsTitle.text = element.title
                cell.newsDescription.text = element.description
            }
            .disposed(by: disposeBag)
          */
       
        
        /*
        searchBar.rx.text //RxCocoa의 Observable 속성
            .orEmpty //옵셔널이 아니도록 만든다.
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)  //0.5초 기다린다.
            .distinctUntilChanged()
            //.filter{ !$0.isEmpty } //새로운 값이 들어왔고, 비어있는 쿼리는 필터링
            .bind{
                self.viewModel.search($0)
            }
            .disposed(by: disposeBag)
     */
    
    /*
        tableView.rx.itemSelected
            .bind{
                print($0.item)
                self.viewModel.remove($0.item)
            }
            .disposed(by: disposeBag)
        */
        
        tableView.rx.itemSelected
            .bind{
                self.viewModel.tap(index: $0[1])
            }
        
    }
    
    

}


extension FirstViewController :  UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

