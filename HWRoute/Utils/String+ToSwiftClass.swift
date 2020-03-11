//
//  NSObject+SwiftClass.swift
//  routeSwiftTest
//
//  Created by Howe on 2018/7/3.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation
import UIKit
extension String {
    func to_swiftClass() -> AnyClass? {
        // get the project name
        if  let appName: String = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String? {
            //拼接控制器名
//            let name = appName.replacingOccurrences(of: "-Enterprise", with: "")
            let classTemp : AnyClass? = NSClassFromString(appName + "." + self)
            //将控制名转换为类            let classTemp : AnyClass? = NSClassFromString((clsName as! String) + "." + className)
            
            return classTemp
        }
        return nil;
    }
}
