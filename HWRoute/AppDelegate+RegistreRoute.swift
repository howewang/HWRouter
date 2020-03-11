//
//  AppDelegate+RegistreRoute.swift
//  routeSwiftTest
//
//  Created by Howe on 2018/7/3.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation
import UIKit
import JLRoutes


extension AppDelegate {
    func registerRoute(scheme: String) {
        JLRoutes(forScheme: scheme).addRoute("/push/:controller") { [weak self](parameters) -> Bool in
            let nextVC = self?.getNextVC(pageName: parameters["controller"] as! String)
            if nextVC == nil {
                return false
            }
            var params: NSDictionary = [String:Any]() as NSDictionary
            if let paramsKey = parameters[kRouteParamsKey] {
                params = HWNavigationRouter.default.getParams(key: paramsKey as! String, isClean: true)
            }
            
            let destroyStr : String = (parameters[kRouteIsDestroyKey] as? String) ?? "false"
            let destroy : Bool = destroyStr.toBool()!
            let animationStr :String = (parameters[kRouteIsAnimationKey] as? String) ?? "true"
            let animation = animationStr.toBool()
            self?.paramTo(vc: nextVC!, params: params as! [String : Any])
            let currentVC = self?.currentVC()
            if currentVC?.navigationController != nil {
                if destroy == true {
                    currentVC?.hw_should_destrory_self = true
                    nextVC?.hw_should_trigger_destroy = true
                    currentVC?.navigationController?.hw_setPageParameters(params: ["command": "destroy"])
                }
                if currentVC?.navigationController?.delegate == nil {
                    currentVC?.navigationController?.delegate = HWVCRouter.default
                }
                currentVC?.hidesBottomBarWhenPushed = true
                currentVC?.navigationController?.pushViewController(nextVC!, animated: animation!)
                return true
            }
            return false
            
        }
        
        
        JLRoutes(forScheme: scheme).addRoute("/present/:controller") { [weak self](parameters) -> Bool in
            var params: NSDictionary = [String:Any]() as NSDictionary
            if let paramsKey = parameters[kRouteParamsKey] {
                params = HWNavigationRouter.default.getParams(key: paramsKey as! String, isClean: true)
            }

            let animationStr : String = (parameters[kRouteIsAnimationKey] as? String) ?? "true"
            let animation = animationStr.toBool()
            let nextVC = self?.getNextVC(pageName: parameters["controller"] as! String)
            if nextVC == nil {
                return false
            }
            self?.paramTo(vc: nextVC!, params: params as! [String : Any])
            
            let currentVC = self?.currentVC()
            if (nextVC?.isKind(of: UIViewController.self))! {
                let naviationVC = CMWBaseNavigationViewController.init(rootViewController: nextVC!)
                naviationVC.delegate = HWVCRouter.default
                if currentVC?.navigationController != nil {
                    currentVC?.navigationController?.present(naviationVC, animated: animation ?? true, completion: {
                        let isDestroy = ((parameters[kRouteIsDestroyKey] as? String) ?? "falst").toBool()
                        if isDestroy == true {
                            var controllerList = currentVC?.navigationController?.viewControllers
                            controllerList?.removeLast()
                            currentVC?.navigationController?.viewControllers = controllerList!
                            
                        }
                    })
                }else{
                    currentVC?.present(naviationVC, animated: animation!, completion: {
                    
                    })
                }
                return true
            }
            
            if currentVC?.navigationController != nil {
                currentVC?.navigationController?.present(nextVC!, animated: animation ?? true,completion: {
                    let isDestroy = ((parameters[kRouteIsDestroyKey] as? String) ?? "falst").toBool()
                    if isDestroy == true {
                        var controllerList = currentVC?.navigationController?.viewControllers
                        controllerList?.removeLast()
                        currentVC?.navigationController?.viewControllers = controllerList!
                        
                    }
                })
            }else{
                currentVC?.present(nextVC!, animated: animation!, completion: {
                    
                })
            }
            currentVC?.present(nextVC!, animated: animation!, completion: nil)
            return true
        }
        
        
        JLRoutes(forScheme: scheme).addRoute("/pop/:controller") { (parameters) -> Bool in
            let pageName = parameters["controller"] as! String
            var params:NSDictionary = [String:Any]() as NSDictionary
            if let paramsKey = parameters[kRouteParamsKey] {
                params = HWNavigationRouter.default.getParams(key: paramsKey as! String, isClean: true)
            }
            var popVC: UIViewController?
            let currentVC = self.currentVC()
            let animationStr = (parameters[kRouteIsAnimationKey] as? String) ?? "true"
            let animation = animationStr.toBool()
            
            
            if (currentVC.navigationController?.viewControllers.first?.isEqual(currentVC))! {
                if currentVC.presentingViewController != nil {
                    popVC = currentVC.presentingViewController
                    self.paramTo(vc: popVC!, params: params as! [String : Any])
                    currentVC.dismiss(animated: animation!, completion: nil)
                    return true
                }
                return false
            }else {
                if currentVC.navigationController == nil {
                    return false
                }
                if (currentVC.navigationController?.viewControllers.count)! < 2 {
                    return false
                }
                if pageName == "nil" {
                    popVC = currentVC.navigationController?.viewControllers[(currentVC.navigationController?.viewControllers.count)! - 2]
                }else if pageName == "root_page" {
                    currentVC.navigationController?.popToRootViewController(animated: animation!)
                    return true
                }else{
                    let classString = HWVCRouter.default.getPage(pageName: pageName)
                    let className = NSClassFromString(classString!) as! UIViewController.Type
                    for vc in (currentVC.navigationController?.viewControllers)! {
                        if vc.isKind(of: className) {
                            popVC = vc
                            break
                        }
                    }
                }
                self.paramTo(vc: popVC!, params: params as! [String : Any])
                if popVC == currentVC.navigationController?.viewControllers[0] {
                    popVC?.hidesBottomBarWhenPushed = false
                }
                currentVC.navigationController?.popViewController(animated: animation!)
                return true
            }
        }
    }

    func registerDeeplinkRoute(scheme: String) {
        JLRoutes(forScheme: scheme).addRoute("/:controller") {(parameters) -> Bool in
            let pageName = parameters["controller"] as! String
            APPRoute.goToPage(pageName: pageName, params: parameters as NSDictionary, destroy: false, animation: true)
//            var jumpTypeString = HWVCRouter.default.getPageJumpType(pageName: pageName)
//            if  jumpTypeString == nil {
//                jumpTypeString = "push"
//            }
//
//            let nextVC = self?.getNextVC(pageName: pageName)
//             self?.paramTo(vc: nextVC!, params: parameters)
//            let currentVC = self?.currentVC()
//            if currentVC?.navigationController != nil {
//                if currentVC?.navigationController?.delegate == nil {
//                    currentVC?.navigationController?.delegate = HWVCRouter.default
//                }
//                currentVC?.hidesBottomBarWhenPushed = true
//                currentVC?.navigationController?.pushViewController(nextVC!, animated: true)
                return true
//            }
//            return false
        }
    }
    
    private func getNextVC(pageName: String) -> UIViewController? {
        let className = HWVCRouter.default.getPage(pageName: pageName)
        if className == nil {
            return nil
        }
        let tempClass = className?.to_swiftClass() as! UIViewController.Type//NSClassFromString(className!) as! UIViewController.Type
        let vc: UIViewController = tempClass.init()
        return vc
        
    }
    
    func currentVC() -> UIViewController {
        return APPRoute.currentVC()
    }
    
    private func paramTo(vc: UIViewController, params: [String:Any]) {
        if params.count == 0 {
            return
        }
        
        let properties = vc.hw_propertyList()
        for property in properties {
            let param = params[property]
            if param != nil {
                vc.setValue(param, forKey: property)
            }
        }
    }
}
