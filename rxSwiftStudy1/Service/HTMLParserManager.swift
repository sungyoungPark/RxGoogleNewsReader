//
//  HTMLParserManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import UIKit

class HTMLParserManager {
    
    func getHTML(_ urlPath : String, completionBlock: @escaping (String) -> Void) -> Void {
     //   let urlPath = "https://news.google.com/__i/rss/rd/articles/CBMiMWh0dHBzOi8vd3d3Lnl0bi5jby5rci9fbG4vMDEwMV8yMDIxMDEyNzIyMDgxMjQyMznSAUNodHRwczovL20ueXRuLmNvLmtyL25ld3Nfdmlldy5hbXAucGhwP3BhcmFtPTAxMDFfMjAyMTAxMjcyMjA4MTI0MjM5?oc=5"
        let url = NSURL(string: urlPath)


        let session = URLSession.shared


        let task = session.dataTask(with: url! as URL, completionHandler: {
            (data, respons, error) -> Void in
            
            if error == nil{
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)?.components(separatedBy: ["\n","\t"])
                    .filter { $0.range(of: "og:image") != nil }
                    .filter{ $0.range(of: "http") != nil }.map{ String($0).hrefUrl }.joined()
                
                print(urlContent ?? "no contents found")
                completionBlock(urlContent!)
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
