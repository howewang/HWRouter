//
//  RegistPage.swift
//  
//
//  Created by Howe on 2019/1/18.
//

import Foundation

extension HWRouteBase {
    
    func initPageData() {
        //MARK: -  terms
        self.add(page: "test1",                         pageClass: "CMWTermsViewController", jumpType: "present")
        //create wallet
        self.add(page: "auto_create",                   pageClass: "CMWCreateWalletViewController")
    }
    
    
}
