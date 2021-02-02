//
//  KeyWordsManager.swift
//  rxSwiftStudy1
//
//  Created by 박성영 on 2021/02/03.
//

import Foundation

class KeyWordsManager{
    
    func makeKeyWords(_ description : String)->[String]{
        var keyWord_result : [String] = []
        var subKeyWord : [String] = []
        let transDescription = description.replacingOccurrences(of: "..", with: " ")
        let myArr = transDescription.components(separatedBy: [" ","?",",","\"","&","#",";","'"])
        var result : [String:Int] = [:]
        for i in myArr{
            //print(i)
            let update = i.trimmingCharacters(in: .whitespacesAndNewlines)
            if update.count >= 2{
                if update != ""{
                    if result[i] != nil{
                        result[i]! += 1
                    }
                    else{
                        result.updateValue(1, forKey: update)
                    }
                }
            }
        }
        let sort = result.sorted { $0.value > $1.value }
        var temp = -1
        for word in sort {
            //print("word:", word)
            if temp == -1 {
                temp = word.1
                subKeyWord.append(word.0)
            }
            else if temp > Int(word.1){
                temp = Int(word.1)
                if keyWord_result.count + subKeyWord.count > 3{
                    break
                }
                else {
                    keyWord_result = keyWord_result + subKeyWord.sorted()
                    subKeyWord.removeAll()
                    subKeyWord.append(word.0)
                }
            }
            else if temp == Int(word.1){
                subKeyWord.append(word.0)
            }
            else{
                subKeyWord.append(word.0)
            }
            // print("key:",keyWord_result )
            // print("sub : ",subKeyWord)
        }
        subKeyWord = subKeyWord.sorted()
        if keyWord_result.count == 3 {
            return keyWord_result
        }
        else{
            while  true {
                if keyWord_result.count == 3 || subKeyWord.count == 0{
                    return keyWord_result
                }
                keyWord_result.append(subKeyWord.first!)
                subKeyWord.removeFirst()
            }
            return keyWord_result
        }
    }
    
    
    
}
