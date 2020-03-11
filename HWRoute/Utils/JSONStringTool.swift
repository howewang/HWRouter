//
//  JSONStringTool.swift
//  sdfasdfasdf
//
//  Created by Howe on 2018/12/22.
//  Copyright © 2018 Howe. All rights reserved.
//

import Foundation

extension NSArray {
    func jsonString() -> String?{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            let jsonString = String.init(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
    
    static func dicitonary(jsonFile path: String) -> Array<Any>? {
        do {
            let data = try Data.init(contentsOf: URL.init(string: path) ?? URL.init(string: "")!)
            let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? Array<Any>
            if  obj != nil{
                return obj
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func write(to jsonFile: String) -> Bool {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            try? jsonData.write(to: URL.init(string: jsonFile)!)
            return true
        } catch {
            return false
        }
    }
}

//extension Dictionary {
//    func jsonString() -> String? {
//        if JSONSerialization.isValidJSONObject(self) {
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
//                let jsonString = String.init(data: jsonData, encoding: .utf8)
//                return jsonString
//            } catch {
//                return nil
//            }
//        }
//        return nil
//    }
//    static func dicitonary(jsonFile path: String) -> Dictionary? {
//        do {
//            let data = try Data.init(contentsOf: URL.init(string: path) ?? URL.init(string: "")!)
//            let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? Dictionary
//            if  obj != nil{
//                return obj
//            }
//            return nil
//        } catch {
//            return nil
//        }
//    }
//    
//    func write(to jsonFile: String) -> Bool {
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
//            try? jsonData.write(to: URL.init(string: jsonFile)!)
//            return true
//        } catch {
//            return false
//        }
//    }
//    
//}

extension NSDictionary {
    func jsonString() -> String? {
        if JSONSerialization.isValidJSONObject(self) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
                let jsonString = String.init(data: jsonData, encoding: .utf8)
                return jsonString
            } catch {
                return nil
            }
        }
        return nil
    }
    static func dicitonary(jsonFile path: String) -> NSDictionary? {
        do {
            let data = try Data.init(contentsOf: URL.init(string: path) ?? URL.init(string: "")!)
            let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
            if  obj != nil{
                return obj
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func write(to jsonFile: String) -> Bool {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            try? jsonData.write(to: URL.init(string: jsonFile)!)
            return true
        } catch {
            return false
        }
    }
    
}
