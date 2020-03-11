//
//  NSString+DecimalExchange.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/7/19.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation
extension String {
    // MARK: - 十进制转十六进制
    static func decTohex(number:Int) -> String {
        return String(format: "%0X", number)
    }
    
    // MARK: - 十六进制转十进制
//    func hexTodec() -> Int {
//        let tempString = self.replacingOccurrences(of: "0x", with: "")
//        var sum = 0
//        // 整形的 utf8 编码范围
//        let intRange = 48...57
//        // 小写 a~f 的 utf8 的编码范围
//        let lowercaseRange = 97...102
//        // 大写 A~F 的 utf8 的编码范围
//        let uppercasedRange = 65...70
//        for c in tempString.utf8CString {
//            var intC = Int(c.byteSwapped)
//            if intC == 0 {
//                break
//            } else if intRange.contains(intC) {
//                intC -= 48
//            } else if lowercaseRange.contains(intC) {
//                intC -= 87
//            } else if uppercasedRange.contains(intC) {
//                intC -= 55
//            } else {
//                assertionFailure("输入字符串格式不对，每个字符都需要在0~9，a~f，A~F内")
//            }
//            sum = sum * 16 + intC
//        }
//        return sum
//
//    }
    
    func hexTodec() -> NSDecimalNumber {
        let tempString = self.replacingOccurrences(of: "0x", with: "")

        let str = tempString.uppercased()
        var sum: NSDecimalNumber = NSDecimalNumber.init(value: 0)
        for i in str.utf8 {
            sum = sum.multiplying(by: NSDecimalNumber.init(value: 16)).adding(NSDecimalNumber.init(value: Int(i))).subtracting(NSDecimalNumber.init(value: 48))  // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum = sum.subtracting(NSDecimalNumber.init(value: 7))
            }
        }
        return sum
    }
    func hexTodecString(dec: Int = 18) -> String {
        let tempString = self.replacingOccurrences(of: "0x", with: "")
        
        let str = tempString.uppercased()
        var sum: NSDecimalNumber = NSDecimalNumber.init(value: 0)
        for i in str.utf8 {
            let a = NSDecimalNumber.init(value: 16)
            let b = NSDecimalNumber.init(value: Int(i))
            let c = NSDecimalNumber.init(value: 48)
            
            sum = sum.multiplying(by: a).adding(b).subtracting(c)  // 0-9 从48开始
//            if (sum.multiplying(by: NSDecimalNumber.init(string: "10000000000000000000000000000")).int64Value > 0 )  {return "0"}
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum = sum.subtracting(NSDecimalNumber.init(value: 7))
            }
        }
        for _ in 0..<dec {
            sum = sum.dividing(by: NSDecimalNumber.init(value: 10))
        }
        
        return sum.description
    }
    
    func hexTodecStringNoLimited(dec: Int = 18) -> String {
        let tempString = self.replacingOccurrences(of: "0x", with: "")
        
        let str = tempString.uppercased()
        var sum: NSDecimalNumber = NSDecimalNumber.init(value: 0)
        for i in str.utf8 {
            let a = NSDecimalNumber.init(value: 16)
            let b = NSDecimalNumber.init(value: Int(i))
            let c = NSDecimalNumber.init(value: 48)
            
            sum = sum.multiplying(by: a).adding(b).subtracting(c)  // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum = sum.subtracting(NSDecimalNumber.init(value: 7))
            }
        }
        for _ in 0..<dec {
            sum = sum.dividing(by: NSDecimalNumber.init(value: 10))
        }
        
        return sum.description
    }
    
    func hexTodec() -> (String, Int) {
        let tempString = self.replacingOccurrences(of: "0x", with: "")
        
        let str = tempString.uppercased()
        var sum: NSDecimalNumber = NSDecimalNumber.init(value: 0)
        for i in str.utf8 {
            let a = NSDecimalNumber.init(value: 16)
            let b = NSDecimalNumber.init(value: Int(i))
            let c = NSDecimalNumber.init(value: 48)
            
            sum = sum.multiplying(by: a).adding(b).subtracting(c)  // 0-9 从48开始
            
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum = sum.subtracting(NSDecimalNumber.init(value: 7))
            }
        }
        
        return (sum.description,sum.intValue)
    }
    
 }

extension NSDecimalNumber {
    func realNumber(dec: Int = 18) -> NSDecimalNumber{
        var temp = NSDecimalNumber.init(decimal: self.decimalValue)
        for _ in 0..<dec {
            temp = temp.dividing(by: NSDecimalNumber.init(value: 10))
        }
        return temp
    }

}


