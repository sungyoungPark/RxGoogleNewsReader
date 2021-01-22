//
//  ViewController.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/22.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownCities = [String]()
    let allCities = ["New York","London","Oslo","Warsaw","Seoul","Tokyo","GoYang","Praga","Berlin"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
        
    }
    

}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
    
    
    
}
