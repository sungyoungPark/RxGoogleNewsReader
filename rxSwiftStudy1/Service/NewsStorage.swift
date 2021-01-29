//
//  NewsStorage.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/29.
//

import Foundation
import RxSwift

class NewsStorage {
    
    private var newsList : [News] = []
    private lazy var store = BehaviorSubject<[News]>(value: newsList)
    
    func createNews(news : News) { //새로운 메모를 생성하고 배열에 추가
        //print("추가",newsList.count)
        //let news = News(title: title, url: url, imageURL: imageURL, description: description)
        //newsList.insert(news, at: newsList.count)
        newsList.append(news)
        store.onNext(newsList)     //subject에서 새로운 next 이벤트 방출
    
    }
    
    
    func getList() -> Observable<[News]> {  //클래스 외부에서는 이 메소드를 이용해서 subject에 접근한다.
        return store
    }
    
    func getNews(index : Int)  {
        print("tap ",index,"/" ,newsList[index].url ," / " ,newsList[index].description)
    }
    
}
