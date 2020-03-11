//
//  CMWBaseNavigationViewController.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/8/13.
//  Copyright © 2018年 Howe. All rights reserved.
//

import UIKit

class CMWBaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CMWBaseNavigationViewController:UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        return true
    }
}
