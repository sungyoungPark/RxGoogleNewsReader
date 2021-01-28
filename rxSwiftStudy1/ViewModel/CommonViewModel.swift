//
//  CommonViewModel.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import Foundation
import RxCocoa
import RxSwift

class CommonViewModel : NSObject{
    let title : Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let manager : XMLParserManager
   // let newsList : [News]
    
    init(title : String, sceneCoordinator : SceneCoordinatorType, manager : XMLParserManager) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.manager = manager
        //self.newsList = newsList
    }
}
