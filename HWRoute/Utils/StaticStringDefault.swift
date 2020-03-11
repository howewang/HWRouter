//
//  StaticStringDefault.swift
//  CyberMilesWallet
//
//  Created by 5miles_ios_mbp on 2019/6/6.
//  Copyright © 2019 Howe. All rights reserved.
//

import Foundation
enum CMWStaticString: String, CaseIterable {
    //dashboard 接口字段
    case interest_yesterday
    case chart_data
    case total_cmt
    case interest_total
    case available_cmt
    case my_staking
    case bind_validator
    case bind_cube
    case validator
    case owner_address
    case comp_rate
    case email
    case location
    case website
    case pending
    
    //二维码扫描
    case QRCODE_SCAN_SYMBOL_EMPTY
    
    //多钱包本地缓存字段
    case kIsAcceptStakeTerm
    case kWalletMnemonic
    case kMultipleWalletlist
    case kMaionWalletAddress
    //保存自动创建钱包的密码
    case kAutoCreatWalletPassword
    //dapp点击提醒
    case kClickDappAlert
    
    //收藏夹本地缓存字段
    case kCollectionList
    
    //自动生成钱包的密码
    case kAutoWalletPassword
    
    //device id
    case app_uuid_device_id

    //通知
    case kNofitication_needCheckDeepLink

}
