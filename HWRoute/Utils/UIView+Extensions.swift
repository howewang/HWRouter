//
//  UIView+Extensions.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/6/27.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
public extension UIView {
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    var x: CGFloat {
        set (newValue) {
            self.frame = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set (newValue) {
            self.frame = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var width: CGFloat {
        set (newValue) {
            self.frame = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set (newValue) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
        get {
            return self.frame.size.height
        }
    }
    
    var right: CGFloat {
        set (newValue) {
            self.frame = CGRect(x: self.x, y: self.y, width: newValue - self.x, height: self.height)
        }
        get {
            return self.x + self.width
        }
    }
    
    var bottom: CGFloat {
        set (newValue) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: newValue - self.y)
        }
        get {
            return self.y + self.height
        }
    }
    
    func size(_ size: CGSize) {
        self.width = size.width
        self.height = size.height
    }
    
}

