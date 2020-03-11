//
//  HWRouteDefaultKeys.swift
//  routeSwiftTest
//
//  Created by Howe on 2018/7/3.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation

let kRouteSchame = "CMTWalletAppStore"
let kRouteSchameEnterprise = "CMTWalletEnterprise"
let kRouteSchame_Test = "CMTWalletTest"
let kDeepLinkScheme = "cmtwallet"
let kDeepLinkScheme_test = "cmtwallettest"
let kRouteParamsKey = "hw_route_params_key"
let kRouteIsDestroyKey = "hw_route_isDestroy_key"
let kRouteIsAnimationKey = "hw_route_isAnimation_key"
let KRouteIsCreateWithNib = "hw_route_isCreateWithNib_key"
let kHWPageParameters = "hw_page_parameters"
let kHWCurrentChildController = "hw_current_active_child_controller"

enum CMWAppBundleId {
    case Enterprise// com.cybermiles.wallettest
    case Enterprise_test
    case AppStore//com.CyberMiles.CMT.Wallet
    
    var bundleId: String {
        switch self {
        case .Enterprise:
            return "com.CyberMiles.CMTWallet.Enterprise"
        case .Enterprise_test:
            return "com.cybermiles.wallettest"
        case .AppStore:
            return "com.CyberMiles.CMT.Wallet"
        }
    }
    
    var scheme: String {
        switch self {
        case .Enterprise:
            return kRouteSchameEnterprise
        case .AppStore:
            return kRouteSchame
        case .Enterprise_test:
            return kRouteSchame_Test
        }
    }
    
    var deepLinkScheme: String {
        switch self {
        case .Enterprise,.AppStore:
            return kDeepLinkScheme
        case .Enterprise_test:
            return kDeepLinkScheme_test
        }
    }
    
    static func currentBundle() -> CMWAppBundleId {
        let bundleId = Bundle.main.bundleIdentifier
        switch bundleId {
        case "com.CyberMiles.CMTWallet.Enterprise":
            return .Enterprise
        case "com.cybermiles.wallettest":
            return .Enterprise_test
        case "com.CyberMiles.CMT.Wallet",.none,.some(_):
            return .AppStore
        }
    }
}
