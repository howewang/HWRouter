//
//  DeeplinkManager.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/11/20.
//  Copyright © 2018 Howe. All rights reserved.
//

import Foundation

class DeeplinkManager: NSObject {
    public static let `default`: DeeplinkManager = {
        return DeeplinkManager()
    }()
    
    var deeplinkList: NSMutableArray = NSMutableArray()
    
    func save(_ deeplink: URL) {
        if deeplink.absoluteString.count > 0 {
            deeplinkList.add(deeplink)
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: CMWStaticString.kNofitication_needCheckDeepLink.rawValue), object: nil)
        }
    }
    
    func checkDeeplink() -> Bool {
        if deeplinkList.count == 0 {
            return false
        }        
        return true
    }
    
    func checkDeeplink(_ link: String) -> Bool {
        if link.count > 17 {
            if link.substring(with: Range.init(from: 0, to: 16)) == "cmtwallet://dapp" {
                let url = URL.init(string: link)
                if url != nil {
                    self.save(url!)
                    return true
                }
            }
        }
        if link.count > 20 {
            if link.substring(with: Range.init(from: 0, to: 20)) == "cmtwallet://transfer" {
                let url = URL.init(string: link)
                if url != nil {
                    self.save(url!)
                    return true
                }
            }
        }
        return false
    }
    
    func getCurrentDeeplink() -> URL? {
        if deeplinkList.count == 0 {
            return nil
        }
        let url = deeplinkList.firstObject as! URL
        deeplinkList.removeAllObjects()
        return url
    }
    
}
