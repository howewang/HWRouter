//
//  HWVCRouter.swift
//  routeSwiftTest
//
//  Created by Howe on 2018/7/3.
//  Copyright © 2018年 Howe. All rights reserved.
//

import UIKit
import JavaScriptCore
class HWVCRouter: NSObject,UINavigationControllerDelegate {

    var route: HWRouteBase {
        get{
            return self.routeBase
        }
    }
    
    private var routeBase: HWRouteBase = HWRouteBase()
    public static let `default`: HWVCRouter = {
        return HWVCRouter()
    }()
    
    override init() {
        super.init()
    }
    
    func getPageClass(pageName: String) -> AnyClass? {
        let value = self.routeBase.getPageClassString(pageName: pageName)
        return NSClassFromString(value)
    }
    
    func getPageJumpType(pageName: String) -> String? {
        return self.routeBase.getPageJumpType(pageName: pageName)
    }
    
    func getPageName(className: String) -> String? {
        return self.routeBase.getPageName(className:className)
    }
    
    func getPage(pageName: String) -> String? {
        return self.routeBase.getPageClassString(pageName: pageName)
    }
    
    func getPageConfig(pageClass: AnyClass) -> PageModel? {
        return self.routeBase.getPageConfig(pageClass:pageClass)
    }
    
    func getPageConfig(pageName: String) -> PageModel? {
        return self.routeBase.getPageConfig(pageName: pageName)
    }
    

    //navigation delegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let params = navigationController.hw_getPageParameters()
        if params == nil || params?.count == 0  {
            return
        }
        let command = params!.value(forKey: "command") as! String
        let destroy = viewController.hw_should_trigger_destroy
        if command == "destroy" && destroy == true{
            viewController.hw_should_trigger_destroy = nil
            let targetIndex = navigationController.viewControllers.firstIndex(of: viewController)
            if targetIndex == NSNotFound {
                return
            }
            let controllers = NSMutableArray(array: (navigationController.viewControllers as NSMutableCopying) as! [Any]) as NSMutableArray
            for vc in navigationController.viewControllers {
                if vc.hw_should_destrory_self == true {
                    let index = navigationController.viewControllers.firstIndex(of: vc)
                    if index! < targetIndex! {
                        controllers.remove(vc)
                    }
                }
            }
            let count = controllers.count
            if count < 1 {
                return
            }
            
            navigationController.viewControllers = controllers as! [UIViewController]
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            if toVC == navigationController.viewControllers[0] {
                toVC.hidesBottomBarWhenPushed = false
            }
        }

        return nil
    }
}

