//
//  CMWBaseViewController.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/6/26.
//  Copyright © 2018年 Howe. All rights reserved.
//

import Foundation
import UIKit


class CMWBaseViewController: UIViewController {
    
    var isShowBackButton: Bool = false
    var navigationBar: UINavigationBar {
        get {
            return self.m_navigationBar
        }
    }
    
    override var title: String? {
        didSet {
            self.m_navigationBar.title = title
        }
    }
    
    var localizedTitle: String? {
        didSet {
            self.m_navigationBar.title = NSLocalizedString(localizedTitle ?? "", comment: "")
        }
    }
    
    var topHight: CGFloat {
        get {
            return 80 + NSString.isIphneXH()
        }
    }
    
    
    private lazy var m_navigationBar: CMTNavigationBar = {
        let navi = CMTNavigationBar.newBar(self.navigationBarStatus())
        return navi
    }()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
      
    }
    
    func rightButton(image: UIImage?, title: String? , target: Any, action: Selector) {
        self.m_navigationBar.rightButton(image: image, title: title, target: target, action: action)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController != nil {
            
            self.navigationController?.navigationBar.isHidden = true
            
            self.view.addSubview(self.m_navigationBar)
            
            self.m_navigationBar.backButtonView.isHidden = !self.showBackBarItem()
            self.m_navigationBar.backButton(target: self, action: #selector(CMWBaseViewController.cmw_back))
            self.m_navigationBar.leftButton(target: self, action: #selector(CMWBaseViewController.cmw_backRoot))
            self.m_navigationBar.leftButtonView.isHidden = !self.showLeftButton()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func showBackBarItem() -> Bool {
        return self.canPop()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showLeftButton() -> Bool {
        return false
    }
    
    @objc func cmw_backRoot() {
        self.popRootPage()
    }
    
    @objc func cmw_back(){
        self.popWithPage()
    }
    
    func navigationBarStatus() -> CMWNavigationBarStatus {
        return .Blue
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

