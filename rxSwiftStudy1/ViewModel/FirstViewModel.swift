//
//  FirstViewModel.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import Foundation
import RxCocoa
import RxSwift
import Action

class FirstViewModel : CommonViewModel{
    
    var list : Observable<[News]> {
        return manager.storage.getList()
    }
  
    func tap(index : Int){
        manager.storage.getNews(index: index)
    }
    
    lazy var detailNews : Action <News, Void> = {   //상세 뉴스 보기 화면과 바인딩
        return Action { news  in
            let webnewsVM = WebNewsViewModel(title: "뉴스 상세", sceneCoordinator: self.sceneCoordinator, manager: self.manager)
            webnewsVM.url = news.url
            let newsScene = Scene.webNews(webnewsVM)
            
            return self.sceneCoordinator.transition(to: newsScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }()
    
  
/*
    func search(_ str : String){
        print(str)
        if str == ""{
            print("bin")
        }
        
        print(allCities.filter{ $0.hasPrefix(str)})
        shownCities.onNext(allCities.filter{ $0.hasPrefix(str)})
    }
    */
    
    
}
