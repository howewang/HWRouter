//
//  UIViewController+HWNavigation.swift
//  routeSwiftTest
//
//  Created by Howe on 2018/7/3.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation
import UIKit
private var key: Void?
extension UIViewController {
    
    private var hw_PageParameters: NSDictionary? {
        get {
            return objc_getAssociatedObject(self, &key) as? NSDictionary
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var hw_CurrentChildController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIViewController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var hw_should_destrory_self: Bool? {
        get {
            return objc_getAssociatedObject(self, &key) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var hw_should_trigger_destroy: Bool? {
        get {
            return objc_getAssociatedObject(self, &key) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func hw_getPageParameters() -> NSDictionary? {
        var params = self.hw_PageParameters
        if params != nil {
            self.hw_PageParameters = nil
            return params
        }
        
        let parent = self.parent
        if parent != nil {
            let activeChild = parent?.hw_CurrentChildController
            if activeChild != self {
                return params
            }
            params = parent?.hw_PageParameters
            if params != nil {
                parent?.hw_PageParameters = nil
            }
        }
        return params
    }
    
    func hw_setPageParameters(params: NSDictionary) {
        let originParams = self.hw_PageParameters
        if originParams == nil {
            self.hw_PageParameters = params
            return
        }
        
        let newParams = NSMutableDictionary(dictionary: originParams! )
        newParams.setValuesForKeys(params as! [String : Any])
        
        self.hw_PageParameters = newParams
    }
    
    
    //navigation
    func goToPage(pageName: String, params: NSDictionary = NSDictionary(), destroy: Bool = false, animation: Bool = true) {
        APPRoute.goToPage(pageName: pageName, params: params, destroy: destroy, animation: animation)
    }
    
    func popWithPage(pageName: String = "nil", params: NSDictionary = NSDictionary(), animation: Bool = true) {
        APPRoute.popWithPage(pageName: pageName, params: params, animation: animation)
    }
    
    func popRootPage(animation: Bool = true) {
        APPRoute.popToRoot(animation: animation)
    }
    
    var pageName: String {
        get {
            return HWVCRouter.default.getPageName(className: self.className) ?? ""
        }
    }
    
    func canPop() -> Bool {
        
        if self.navigationController == nil {
            return false
        }
        if (self.navigationController?.viewControllers.count)! < 2 {
            return false
        }
        
        if (self.navigationController?.viewControllers.first?.isEqual(self))! {
            if self.presentingViewController != nil {
                return true
            }else{
                return false
            }
            
        }
         return true
        
    }
}


class APPRoute {
    //navigation
    static func goToPage(pageName: String, params: NSDictionary = NSDictionary(), destroy: Bool = false, animation: Bool = true) {
        let urlString = NSMutableString()
        var jumpTypeString = HWVCRouter.default.getPageJumpType(pageName: pageName)
        if  jumpTypeString == nil {
            jumpTypeString = "push"
        }
        
        urlString.append(String(format: "%@://%@/%@?", CMWAppBundleId.currentBundle().scheme,jumpTypeString!,pageName))
        let paramsArray = NSMutableArray()
        if params.count > 0 {
            let paramsKey = HWNavigationRouter.default.saveParams(params: params)
            paramsArray.add(String(format: "%@=%@", kRouteParamsKey,paramsKey))
        }
        var destroyStr = "false"
        if destroy == true {
            destroyStr = "true"
        }
        paramsArray.add(String(format: "%@=%@", kRouteIsDestroyKey,destroyStr))
        var animationStr = "true"
        if animation == false {
            animationStr = "false"
        }
        paramsArray.add(String(format: "%@=%@", kRouteIsAnimationKey,animationStr))
        if paramsArray.count > 0 {
            urlString.append(paramsArray.componentsJoined(by: "&"))
        }
        UIApplication.shared.open(URL(string: urlString as String)!, options: [:]) { (success) in
            
        }
    }
    
    static func popWithPage(pageName: String = "nil", params: NSDictionary = NSDictionary(), animation: Bool = true) {
        let urlString = NSMutableString()
        urlString.append(String(format: "%@://pop/%@?", CMWAppBundleId.currentBundle().scheme,pageName))
        
        let paramsArray = NSMutableArray()
        if params.count > 0 {
            let paramsKey = HWNavigationRouter.default.saveParams(params: params)
            paramsArray.add(String(format: "%@=%@", kRouteParamsKey,paramsKey))
        }
        var animationStr = "true"
        if animation == false {
            animationStr = "false"
        }
        paramsArray.add(String(format: "%@=%@", kRouteIsAnimationKey,animationStr))
        
        if paramsArray.count > 0 {
            urlString.append(paramsArray.componentsJoined(by: "&"))
        }
        UIApplication.shared.open(URL(string: urlString as String)!, options: [:]) { (success) in
            
        }
    }
    
    static func popToRoot(animation: Bool = true) {
        let urlString = NSMutableString()
        urlString.append(String(format: "%@://pop/%@?", CMWAppBundleId.currentBundle().scheme,"root_page"))
        
        let paramsArray = NSMutableArray()
       
        var animationStr = "true"
        if animation == false {
            animationStr = "false"
        }
        paramsArray.add(String(format: "%@=%@", kRouteIsAnimationKey,animationStr))
        
        if paramsArray.count > 0 {
            urlString.append(paramsArray.componentsJoined(by: "&"))
        }
        
        UIApplication.shared.open(URL(string: urlString as String)!, options: [:]) { (success) in
            
        }
    }
    
    public static func currentVC() -> UIViewController {
        var currentVC: UIViewController?
        var rootVC = UIApplication.shared.windows.first?.rootViewController
    
        repeat {
            if (rootVC?.isKind(of: UINavigationController.self))! {
                let nav = rootVC as! UINavigationController
                currentVC = nav.viewControllers.last
                rootVC = currentVC?.presentedViewController
                continue
            }else if (rootVC?.isKind(of: UITabBarController.self))!{
                let tabVC = rootVC as! UITabBarController
                currentVC = tabVC
                rootVC = tabVC.viewControllers?[tabVC.selectedIndex]
                continue
            }else if (rootVC?.isKind(of: BaseViewController.self))! {
                currentVC = rootVC
                break
            }else if (rootVC?.isKind(of: UIAlertController.self))! {
                currentVC = rootVC
                break
            }
        }while rootVC != nil
        return currentVC!
    }
}
