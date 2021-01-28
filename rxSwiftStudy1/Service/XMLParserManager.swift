//
//  XMLParserManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import UIKit

class XMLParserManager : NSObject, XMLParserDelegate{
    
    var newsList: [News]?
    var news : News?
    var currentElement : String?
    
    func start(){
        let parser = XMLParser(contentsOf: URL(string: "https://news.google.com/rss?gl=KR&hl=ko&ceid=KR:ko")!)
        newsList = [News]()
        parser?.delegate = self
        parser!.parse()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item"{
            news = News()
        }
        
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "title"{
            news?.title = string
        }
        if currentElement == "link"{
            news?.url = string
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item"{
            newsList?.append(news!)
            
            let url = NSURL(string: news!.url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: url! as URL, completionHandler: {
                (data, respons, error) -> Void in
                
                if error == nil{
                    let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)?.components(separatedBy: ["<",">"])
                        .filter { $0.range(of: "og:image") != nil }
                        .filter{ $0.range(of: "http") != nil }.map{ String($0).hrefUrl }.joined()
                    
                    print(urlContent ?? "no contents found")
                    
                    if urlContent != nil{
                        self.news?.imageURL = urlContent!
                        self.newsList?.append(self.news!)
                    }
                } else {
                    print("Eror 발생")
                }
                
            })
            
            task.resume()
        }
        
    }
    
}
