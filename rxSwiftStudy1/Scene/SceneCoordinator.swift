//
//  SceneCoordinator.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/27.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator : SceneCoordinatorType{  //화면 전환을 담당
    
    private let bag = DisposeBag() //리소스 정리를 위해 사용됨
    
    private var window : UIWindow  //화면 전환을 담당하므로 갖고 있어야 한다
    private var currentVC :UIViewController // 현재 화면
    
    required init(window : UIWindow){
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        
        let subject = PublishSubject<Void>()
        let target = scene.instantiate()  //Scene 열거형에서 구현함
        
        switch style {
        case .root:  //rootviewController만 바꿔주면 됨
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
        case .push:  //navigationCotroller에 임베드 될때만 의미가 있음
            guard let nav = currentVC.navigationController  //navigationCotroller에 임베드 되어 있지 않다면 에러
            else{
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.pushViewController(target, animated: animated)
            currentVC = target
            
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target

        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController{
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            }
            else if let nav = self.currentVC.navigationController{
                guard nav.popViewController(animated: animated) !=  nil
                else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            }
            else{
                completable(.error(TransitionError.unknown))
            }
            return Disposables.create()
        }
    }
    
    
    
}
