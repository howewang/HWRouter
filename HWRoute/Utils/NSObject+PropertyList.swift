//
//  NSObject+PropertyList.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/7/6.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation

extension NSObject {
    class func hw_propertyList() -> [String] {
        // 接受属性个数
        var count: UInt32 = 0
        // 1. 获取"类"的属性列表,返回属性列表的数组,可选项
        let list = class_copyIvarList(self,&count)
        var propertyList = [String]()
        // 2. 遍历
        for i in 0..<Int(count) {
            // 3. 根据下标获取属性
            let pty = list?[i] // objc_property_t?
            // 4. 获取'属性'的名称 C语言字符串
            // Int8 -> Byte -> Char => C 语言的字符串
            let  cName = ivar_getName(pty!)
            // 5. 转换成String 的字符串
            let name = String(utf8String: cName!)
            propertyList.append(name!)
        }
        // 释放C 语言的对象
        free(list)
        return propertyList
    }
    
    func hw_propertyList() -> [String] {
        // 接受属性个数
        var count: UInt32 = 0
        // 1. 获取"类"的属性列表,返回属性列表的数组,可选项
        let list = class_copyIvarList(self.classForCoder,&count)
        var propertyList = [String]()
        // 2. 遍历
        for i in 0..<Int(count) {
            // 3. 根据下标获取属性
            let pty = list?[i] // objc_property_t?
            // 4. 获取'属性'的名称 C语言字符串
            // Int8 -> Byte -> Char => C 语言的字符串
            let  cName = ivar_getName(pty!)
            // 5. 转换成String 的字符串
            let name = String(utf8String: cName!)
            propertyList.append(name!)
        }
        // 释放C 语言的对象
        free(list)
        return propertyList
    }
    
}
