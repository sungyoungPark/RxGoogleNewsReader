//
//  SceneCoordinatorTYpe.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType{
    @discardableResult
    func transition(to scene : Scene, using style : TransitionStyle, animated: Bool) -> Completable  //새로운 씬을 표시
    
    @discardableResult
    func close(animated : Bool)-> Completable //현재 씬을 닫고 이전 씬으로 돌아감
}
