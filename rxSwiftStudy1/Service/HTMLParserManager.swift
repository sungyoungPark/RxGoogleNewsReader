//
//  HTMLParserManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import UIKit

class HTMLParserManager {
    
    var finList : [News]
    var count = 0
    
    init(newsList : [News]) {
        finList = [News]()
        var index = 0

        for news in newsList{
            getHTML(news.url){ res in
                let add = News()
                add.title = news.title
                add.description = res
                self.finList.append(add)
            }
        }
    }
    
    
    func getHTML(_ urlPath : String ,completionBlock: @escaping (String) -> Void) -> Void {
      
        let url = NSURL(string: urlPath)

        let session = URLSession.shared

        let task = session.dataTask(with: url! as URL, completionHandler: {
            (data, respons, error) -> Void in
            
            if error == nil{
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)?.components(separatedBy: ["<",">"])
                    .filter { $0.range(of: "og:image") != nil }
                    .filter{ $0.range(of: "http") != nil }.map{ String($0).hrefUrl }.joined()
                
                print(urlContent ?? "no contents found")
                if (urlContent != nil){
                    completionBlock(urlContent!)
                }
            } else {
                print("Eror 발생")
            }
            
        })

        task.resume()
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
