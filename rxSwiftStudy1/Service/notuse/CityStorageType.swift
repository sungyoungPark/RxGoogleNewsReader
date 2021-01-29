//
//  CityStorageType.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import Foundation
import RxSwift

protocol CityStorageType {
    
    @discardableResult
    func cityList() -> Observable<[String]>
    
}
