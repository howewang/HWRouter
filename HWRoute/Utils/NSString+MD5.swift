//
//  NSString+MD5.swift
//  sdfasdfasdf
//
//  Created by Howe on 2019/1/18.
//  Copyright © 2019 Howe. All rights reserved.
//

import Foundation
import CommonCrypto

extension NSString {
    func hw_MD5() -> NSString? {
        let cStr = self.cString(using: String.Encoding.utf8.rawValue)
        var result =  UnsafeMutablePointer<cc_t>.allocate(capacity: 1)
        result = CC_MD5(cStr, CC_LONG(strlen(cStr!)), result)
        return NSString.init(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15])
        
    }
}

extension String {
    func hw_MD5() -> String? {
        let cStr = self.cString(using: String.Encoding.utf8)
        var result =  UnsafeMutablePointer<cc_t>.allocate(capacity: 1)
        result = CC_MD5(cStr, CC_LONG(strlen(cStr!)), result)
        return String.init(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15])
        
    }
}
