//
//  HWNavigationRouter.swift
//  routeSwiftTest
//
//  Created by Howe on 2018/7/3.
//  Copyright © 2018年 Howe. All rights reserved.
//

import UIKit

class HWNavigationRouter: NSObject {
    public static let `default`: HWNavigationRouter = {
        return HWNavigationRouter()
    }()
    
    var paramsContent: NSMutableDictionary = NSMutableDictionary()
    
    func saveParams(params: NSDictionary) -> String {
        let keys = params.allKeys as! [String]
        let paramsJSONString = "\(keys.joined(separator: "$").toBase64)\(NSDate().description)" as String
        let hashKey = paramsJSONString.hw_MD5() as String?
        self.paramsContent.setObject(params, forKey: hashKey! as NSCopying)
        return hashKey!
    }
    
    func getParams(key: String, isClean: Bool) -> NSDictionary {
        if key.count == 0 {
            return NSDictionary()
        }
        
        let params = self.paramsContent.object(forKey: key)
        if  isClean == true {
            self.paramsContent.removeObject(forKey: key)
        }

        if  params != nil{
            return params as! NSDictionary
        }
        return NSDictionary()
    }
}
