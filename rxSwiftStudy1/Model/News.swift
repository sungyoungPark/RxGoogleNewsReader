//
//  News.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import Foundation

class News{
    var title : String
    var url : String
    var imageURL : String
    var description : String
    
    
    init() {
        self.title = ""
        self.url = ""
        self.imageURL = ""
        self.description = ""
    }
    
    init(title : String, url : String, imageURL : String, description : String) {
        self.title = title
        self.url = url
        self.imageURL = imageURL
        self.description = description
    }
    
}
