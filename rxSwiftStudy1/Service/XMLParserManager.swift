//
//  XMLParserManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import Foundation

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
        }

    }
    
}
