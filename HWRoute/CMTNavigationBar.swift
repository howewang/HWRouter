//
//  CMTNavigationBar.swift
//  CyberMilesWallet
//
//  Created by Howe on 2018/8/17.
//  Copyright © 2018年 Howe. All rights reserved.
//

import UIKit

enum CMWNavigationBarStatus {
    case Blue
    case White
}

class CMTNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    var barStatus: CMWNavigationBarStatus = .Blue
    
    static func newBar(_ status: CMWNavigationBarStatus = .Blue) -> CMTNavigationBar {
        let navi = CMTNavigationBar.init(frame: .init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 80 + NSString.isIphneXH()))
        navi.barStatus = status
        navi.initView()
        return navi
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        switch self.barStatus {
        case .Blue:
            titleLabel.textColor = UIColor.white
        case .White:
            titleLabel.textColor = UIColor.textNormalColor
        }
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var backButtonView: UIButton = {
        let backButtonView = UIButton(type: .custom)
        let imageView = UIImageView.init(frame: CGRect.init(x: 12, y: 10, width: 20, height: 20))
        
        switch self.barStatus {
        case .Blue:
            imageView.image = UIImage(named: "navigation_back")
        case .White:
            imageView.image = UIImage(named: "black_icon_gray")
        }
        backButtonView.addSubview(imageView)
        return backButtonView
    }()
    
    lazy var leftButtonView: UIButton = {
        let leftButtonView = UIButton(type: .custom)
        let imageView = UIImageView.init(frame: CGRect.init(x: 12, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: "go_home")
        leftButtonView.addSubview(imageView)
        return leftButtonView
    }()
    
    lazy var rightButtonView: UIButton = {
        let rightButtonView = UIButton(type: .custom)
        return rightButtonView
    }()
    
    func rightButton(image: UIImage?, title: String? , target: Any, action: Selector) {
        self.rightButtonView.removeAllSubviews()
        if image != nil {
            let imageView = UIImageView.init(frame: .init(x: 20.0, y: 8.0, width: 24, height: 24))
            imageView.image = image
            self.rightButtonView.addSubview(imageView)
        }else if title != nil {
            let label = UILabel.init(frame: .init(x: 20.0, y: 0.0, width: 40, height: 40))
            switch self.barStatus {
            case .Blue:
                label.textColor = UIColor.white
            case .White:
                label.textColor = UIColor.textNormalColor
            }
            
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .right
            label.text = title
            let size = label.sizeThatFits(CGSize.init(width: 9999, height: 40))
            if size.width > 40 {
                label.frame = .init(x: 20.0, y: 0.0, width: size.width, height: 40)
                rightButtonView.snp.updateConstraints { (update) in
                    update.width.equalTo(20 + size.width)
                }
            }
            self.rightButtonView.addSubview(label)
        }
        self.rightButtonView.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func backButton(target: Any, action: Selector) {
        self.backButtonView.addTarget(target, action: action, for: .touchUpInside)
    }
    func leftButton(target: Any, action: Selector) {
        self.leftButtonView.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func initView() {
        switch self.barStatus {
        case .Blue:
            self.backgroundColor = UIColor.appTintColor
            self.barTintColor = UIColor.appTintColor
        case .White:
            self.backgroundColor = UIColor.white
            self.barTintColor = UIColor.white
        }
        
        
        self.setBackgroundImage(UIImage.init(), for: .default)
        self.shadowImage = UIImage.init()
        
        self.addSubview(self.backButtonView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.rightButtonView)
        self.addSubview(self.leftButtonView)
        
        backButtonView.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.width.equalTo(50)
            make.height.equalTo(40)
            make.bottom.equalTo(-10)
        }
        
        leftButtonView.snp.makeConstraints { (make) in
            make.left.equalTo(backButtonView.snp.right).offset(8)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.bottom.equalTo(-10)
        }
        
        rightButtonView.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.bottom.equalTo(-10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftButtonView.snp.right).offset(15)
            make.right.equalTo(rightButtonView.snp.left).offset(-43)
            make.height.equalTo(40)
            make.bottom.equalTo(-10)
        }
        
        
        if self.barStatus == .White {
            let spaceLine = UIView()
            spaceLine.backgroundColor = UIColor.appNavigationSpaceLineColor
            self.addSubview(spaceLine)
            spaceLine.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(-0.5)
                make.height.equalTo(0.5)
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect.init(x: 0, y: 0, width: self.width, height: 80 + NSString.isIphneXH())
        for view in self.subviews {
            if view.className.contains("Background") {
                view.frame = self.bounds
            }
//            else if view.className.contains("ContentView") {
//                view.center = CGPoint.init(x: self.width / 2, y: self.height - view.height / 2 - 10)
//            }
        }
    }
}
