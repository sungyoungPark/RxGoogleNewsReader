//
//  AppDelegate.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let manager = XMLParserManager()
        manager.start()
        let html = HTMLParserManager(newsList: manager.newsList!)
        let coordinator = SceneCoordinator(window: window!)
        let firstViewModel = FirstViewModel(title: "나의 메모", sceneCoordinator: coordinator, newsList : html.finList)
        let listScene = Scene.list(firstViewModel)
        
        coordinator.transition(to: listScene, using: .root, animated: false)
        
        return true
    }

    // MARK: UISceneSession Lifecycle
/*
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
*/

}

