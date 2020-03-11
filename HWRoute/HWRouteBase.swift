//
//  HWRouteBase.swift
//  CyberMilesWallet
//
//  Created by Howe on 2019/1/18.
//  Copyright © 2019 Howe. All rights reserved.
//

import Foundation

class PageModel {
    var pageName : String
    var pageClass : String
    var jumpType : String
    init(name: String, className: String, type: String) {
        self.pageName = name
        self.pageClass = className
        self.jumpType = type
    }
}

class HWRouteBase {
    var pageDic = NSMutableDictionary.init()
    
    init() {
        self.initPageData()
    }
    
    func getPageClassString(pageName: String) ->String{
        guard let page = pageDic.object(forKey: pageName) as? PageModel else {
            return ""
        }
        return page.pageClass
    }
    
    func getPageJumpType(pageName: String) -> String{
        guard let page = pageDic.object(forKey: pageName) as? PageModel else {
            return ""
        }
        return page.jumpType
    }
    
    func getPageName(className: String) ->String? {
        for key in pageDic.allKeys {
            let page = pageDic.object(forKey: key) as! PageModel
            if page.pageClass == className {
                return page.pageName
            }
        }
        return nil
    }
    
    func getPageConfig(pageClass: AnyClass) -> PageModel? {
        for key in pageDic.allKeys {
            let page = pageDic.object(forKey: key) as! PageModel
            if pageClass.self == NSClassFromString(page.pageClass) {
                return page
            }
        }
        return nil
    }
    
    func getPageConfig(pageName: String) -> PageModel? {
        for key in pageDic.allKeys {
            let page = pageDic.object(forKey: key) as! PageModel
            if page.pageName == pageName {
                return page
            }
        }
        return nil
    }
    func add(page pageName: String, pageClass: String, jumpType: String = "push") {
        pageDic.setObject(PageModel.init(name: pageName, className: pageClass, type: jumpType), forKey: pageName as NSCopying)
    }
    
}


