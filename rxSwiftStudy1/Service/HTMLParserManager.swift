//
//  HTMLParserManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import UIKit

class HTMLParserManager {
    
    func getHTML(){
        let urlPath = "https://news.google.com/__i/rss/rd/articles/CBMiPmh0dHA6Ly93d3cubWVkaWF0b2RheS5jby5rci9uZXdzL2FydGljbGVWaWV3Lmh0bWw_aWR4bm89MjExNjY40gFBaHR0cDovL3d3dy5tZWRpYXRvZGF5LmNvLmtyL25ld3MvYXJ0aWNsZVZpZXdBbXAuaHRtbD9pZHhubz0yMTE2Njg?oc=5"
        let url = NSURL(string: urlPath)


        let session = URLSession.shared


        let task = session.dataTask(with: url! as URL, completionHandler: {
            (data, respons, error) -> Void in
            
            if error == nil{
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(urlContent ?? "no contents found")
            } else {
                print("Eror 발생")
            }
            
        })

        task.resume()
    }
    
}
