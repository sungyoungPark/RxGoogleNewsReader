//
//  XMLParserManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import UIKit
import RxSwift

class XMLParserManager : NSObject, XMLParserDelegate{
    
    let storage = NewsStorage()
    
    var currentElement : String?
    var isLock = false
    var title : String?
    var link : String?
    
    func start(){
        let parser = XMLParser(contentsOf: URL(string: "https://news.google.com/rss?gl=KR&hl=ko&ceid=KR:ko")!)
        parser?.delegate = self
        parser!.parse()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item"{
            isLock = true
            title = ""
            link = ""
        }
        
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == "title" && isLock == true{
            title! += string
        }
        if currentElement == "link" && isLock == true{
            link! += string
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item"{
            //newsList.append(news!)
            //print("last",title,link)
            
            let news = News()
            news.title = title!
            news.url = link!
            let url = NSURL(string: link!)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url! as URL, completionHandler: {
                (data, respons, error) -> Void in
                
                if error == nil{
                    if let html = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)?.components(separatedBy: ["<",">"]) {
                        
                        let urlContent = html
                            .filter { $0.range(of: "og:image") != nil }
                            .filter{ $0.range(of: "http") != nil }.map{ String($0).hrefUrl }.joined()
                        
                        let description  = html
                            .filter { $0.range(of: "og:description") != nil }
                            .map{ String($0).hrefUrl }.joined().replacingOccurrences(of: "/", with: "")
                        
                        //print("des",description, url )
                        if (!description.isEmpty){
                            //print(urlContent ?? "no contents found")
                            news.description = description
                            // news.imageURL = urlContent
                            
                            if let imageURL = URL(string: urlContent){
                                
                                DispatchQueue.global().async {
                                    if let data = try? Data(contentsOf: imageURL) {
                                        DispatchQueue.main.async {
                                            news.image = UIImage(data: data)
                                        }
                                    }
                                }
                            }
                            self.storage.createNews(news: news)
                        }
                    }
                } else {
                    print("Eror 발생")
                }
                
            })
            
            task.resume()
        }
        //isLock = false
    }
    
}

extension String {
    func getUrl() -> String? {
        let rss = self.split { (char) -> Bool in
            return char == ">"
        }
        if let final = rss.last?.split(separator: "<"), let first = final.first {
            return String(first)
        }
        return nil
    }
    
    var hrefUrl: String {
        let matchString = "=\""
        let arrComponents = self.components(separatedBy: matchString)
        if let first = arrComponents.last, let str = first.split(separator: "\"").first {
            
            return String(str)
        }
        return ""
    }
}
