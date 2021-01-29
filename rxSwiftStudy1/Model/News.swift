//
//  News.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/01/28.
//

import UIKit

class News{
    var title : String
    var url : String
    var image : UIImage?
    var description : String
    
    
    init() {
        self.title = ""
        self.url = ""
        self.image = UIImage()
        self.description = ""
    }
    
    init(title : String, url : String, image : UIImage, description : String) {
        self.title = title
        self.url = url
        self.image = image
        self.description = description
    }
    
}
