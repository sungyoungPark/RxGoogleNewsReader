//
//  CityStorage.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import Foundation
import RxSwift

class CityStorage : CityStorageType {
    private var allCities = ["New York","London","Oslo","Warsaw","Seoul","Tokyo","GoYang","Praga","Berlin"]
    
    private lazy var store = BehaviorSubject<[String]>(value: allCities)
    
    @discardableResult
    func cityList() -> Observable<[String]> {  //클래스 외부에서는 이 메소드를 이용해서 subject에 접근한다.
        return store
    }
    
}
