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
    
    //private var allCities = ["New York","London","Oslo","Warsaw","Seoul","Tokyo","GoYang","Praga","Berlin"]
    //private lazy var shownCities = BehaviorSubject<[News]>(value: newsList)
 
   // var cityList : Observable<[News]> {
   //     return shownCities
   // }
    
  
    func tap(index : Int){
        manager.storage.getNews(index: index)
    }
    
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
