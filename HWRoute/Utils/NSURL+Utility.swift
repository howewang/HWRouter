//
//  NSURL+Utility.swift
//  sdfasdfasdf
//
//  Created by Howe on 2018/12/22.
//  Copyright © 2018 Howe. All rights reserved.
//

import Foundation
extension URL {
    static func urlEncode(_ sourceText: String) -> String? {
        
       let result = sourceText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.init(charactersIn: "!*'();:@&=+$,/?%#[]") as CharacterSet)
        return result
        
    }
    
    static func urlDecodeing(_ sourceText: String) -> String? {
        
        let result = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, sourceText as CFString, "" as CFString)
        return result as String?
        
    }
    
    static func parserQueryKey(_ queryText : String , startIndex : NSInteger) -> (String?,NSInteger) {
        
        var length = 0;
        let tempString = NSString.init(string: queryText)
        for index in startIndex..<queryText.count {
            let ch = tempString.substring(to: index)
            if ch == "=" {
                break
            }else{
                length+=1
            }
        }
        let key = tempString.substring(with: NSRange.init(location: startIndex, length: length))
        let index = startIndex + length + 1
        return (key,index)
        
    }
    
    static func parserQueryValue(_ queryText: String , startIndex: NSInteger) -> (String?,NSInteger) {
        
        var length = 0;
        let tempString = NSString.init(string: queryText)
        for index in startIndex..<queryText.count {
            let ch = tempString.substring(to: index)
            if ch == "&" {
                break
            }else{
                length+=1
            }
        }
        let key = tempString.substring(with: NSRange.init(location: startIndex, length: length))
        let index = startIndex + length + 1
        return (key,index)
        
    }
    
    
    static func parserQueryText(_ queryText: String) -> NSMutableDictionary? {
        
        let paramDic = NSMutableDictionary.init()
        let index = 0
        while true {
            let (key, keyIndex) = URL.parserQueryKey(queryText, startIndex: index)
            if keyIndex >= queryText.count {
                return nil
            }
            let (value, valueIndex) = URL.parserQueryValue(queryText, startIndex: keyIndex)
            if key != nil && value != nil {
                paramDic.setValue(URL.urlDecodeing(value!), forKey: key!)
            }
            if valueIndex >= queryText.count {
                break
            }
        }
        return paramDic
    }
    
    static func generateQueryText(_ params:NSDictionary) -> String {
        var queryText = ""
        let keys = params.allKeys.sorted { (obj1, obj2) -> Bool in
            let key1 = obj1 as! String
            let key2 = obj2 as! String
            let result = key1.compare(key2)
            return result == .orderedAscending
        }
        
        let keyArray = NSArray.init(array: keys)
        keyArray.enumerateObjects { (obj, idx, stop) in
            let key = obj as! String
            var value = params.object(forKey: key)
            if let array = value as? NSArray {
                value = array.jsonString()
            }else if let dict = value as? NSDictionary {
                value = dict.jsonString()
            }
            
            let valueString = value as? String
            if queryText.count == 0 {
                queryText = String.init(format: "%@=%@", URL.urlEncode(key)!,URL.urlEncode(valueString!)!)
            }else{
                queryText = queryText + "&" + String.init(format: "%@=%@", URL.urlEncode(key)!,URL.urlEncode(valueString!)!)
            }
        }
        
        return queryText
    }
    
    
}
