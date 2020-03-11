//
//  NSObject.swift
//  WalletSwift0002
//
//  Created by Howe on 2018/5/28.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
