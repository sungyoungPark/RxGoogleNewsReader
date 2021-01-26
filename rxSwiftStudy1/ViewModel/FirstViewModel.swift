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
    
    private var allCities = ["New York","London","Oslo","Warsaw","Seoul","Tokyo","GoYang","Praga","Berlin"]
    
    private lazy var shownCities = BehaviorSubject<[String]>(value: allCities)
 
    var cityList : Observable<[String]> {
        return shownCities
    }
    

    func search(_ str : String){
        print(str)
        if str == ""{
            print("bin")
        }
        
        print(allCities.filter{ $0.hasPrefix(str)})
        shownCities.onNext(allCities.filter{ $0.hasPrefix(str)})
    }
    
}
