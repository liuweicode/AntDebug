//
//  AntDebugBar.swift
//  AntDebug
//
//  Created by 刘伟 on 16/11/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit

let AntDebugBarItemHeight:CGFloat = 30
let AntDebugBarButtonHeight:CGFloat = 20

class AntDebugBar: UIWindow
{
    let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
        return contentView
    }()
    
    // 开发环境
    var apiDevelopBtn: UIButton?
    // SIT 环境
    var apiSITBtn: UIButton?
    // UAT 环境
    var apiUATBtn: UIButton?
    // 生产环境
    var apiProductionBtn: UIButton?
    
    // 关闭窗口
    var closeWindowBtn: UIButton?
    // 关闭调试
    var stopDebugBtn: UIButton?
    // 量尺
    var rulerBtn: UIButton?
    // 查看日志
    var logBtn: UIButton?
    
    // 蚂蚁开关
    lazy var antBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("🐜", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    private var isInitialization = true
    
    private func createButton(withTitle title:String, action act:Selector) -> UIButton
    {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setBackgroundImage(ImageUtil.imageWithColor(UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)), for: .normal)
        button.setBackgroundImage(ImageUtil.imageWithColor(UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 0.8)), for: .highlighted)
        button.addTarget(self, action: act, for: .touchUpInside)
        return button
    }
    
    private func settingLayout() {
        
        backgroundColor = UIColor.clear
        windowLevel = UIWindowLevelAlert + 1
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
            make.height.greaterThanOrEqualTo(0)
        }
        
        apiDevelopBtn = createButton(withTitle: "开发环境", action: #selector(changeApiEnvironmentToDEV(_:)))
        contentView.addSubview(apiDevelopBtn!)
        apiDevelopBtn?.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.height.equalTo(AntDebugBarItemHeight)
        }
        
        apiSITBtn = createButton(withTitle: "SIT", action: #selector(changeApiEnvironmentToSIT(_:)))
        contentView.addSubview(apiSITBtn!)
        apiSITBtn?.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(apiDevelopBtn!)
            make.top.equalTo(apiDevelopBtn!.snp.bottom).offset(1)
        })
        
        apiUATBtn = createButton(withTitle: "UAT", action: #selector(changeApiEnvironmentToUAT(_:)))
        contentView.addSubview(apiUATBtn!)
        apiUATBtn?.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(apiDevelopBtn!)
            make.top.equalTo(apiSITBtn!.snp.bottom).offset(1)
        })
        
        apiProductionBtn = createButton(withTitle: "生产环境", action: #selector(changeApiEnvironmentToPRO(_:)))
        contentView.addSubview(apiProductionBtn!)
        apiProductionBtn?.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(apiDevelopBtn!)
            make.top.equalTo(apiUATBtn!.snp.bottom).offset(1)
        })
        
        closeWindowBtn = createButton(withTitle: "关闭窗口", action: #selector(changeApiEnvironmentToPRO(_:)))
        contentView.addSubview(closeWindowBtn!)
        closeWindowBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(apiDevelopBtn!.snp.right).offset(1)
            make.top.equalTo(apiDevelopBtn!.snp.top)
            make.width.height.equalTo(apiDevelopBtn!)
        }
        
        stopDebugBtn = createButton(withTitle: "关闭调试", action: #selector(changeApiEnvironmentToPRO(_:)))
        contentView.addSubview(stopDebugBtn!)
        stopDebugBtn?.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(closeWindowBtn!)
            make.top.equalTo(closeWindowBtn!.snp.bottom).offset(1)
        })
        
        rulerBtn = createButton(withTitle: "量尺", action: #selector(changeApiEnvironmentToPRO(_:)))
        contentView.addSubview(rulerBtn!)
        rulerBtn?.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(closeWindowBtn!)
            make.top.equalTo(stopDebugBtn!.snp.bottom).offset(1)
        })
        
        logBtn = createButton(withTitle: "查看日志", action: #selector(changeApiEnvironmentToPRO(_:)))
        contentView.addSubview(logBtn!)
        logBtn?.snp.makeConstraints({ (make) in
            make.left.width.height.equalTo(closeWindowBtn!)
            make.top.equalTo(rulerBtn!.snp.bottom).offset(1)
        })
        
        contentView.snp.remakeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.8)
            make.bottom.equalTo(logBtn!.snp.bottom)
        }
        
        antBtn.addTarget(self, action: #selector(toggleOpenClose), for: .touchUpInside)
        addSubview(antBtn)
        antBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX).offset(60)
            make.top.equalTo(contentView.snp.bottom)
            make.width.equalTo(45)
            make.height.equalTo(AntDebugBarButtonHeight)
        }
    }

    // 单例
    static let sharedInstance = AntDebugBar()
    
    private init() {
        super.init(frame: UIScreen.main.bounds)
        settingLayout()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isInitialization
        {
            self.frame.size.height = self.contentView.frame.size.height + self.antBtn.frame.size.height
            self.frame.origin.y = -self.contentView.frame.size.height
            isInitialization = false
        }
    }
}


extension AntDebugBar
{
    // 打开／关闭调试窗口
    @objc fileprivate func toggleOpenClose()
    {
        if self.frame.maxY > AntDebugBarButtonHeight
        {
            self.toggleClose()
        }else{
            self.toggleOpen()
        }
    }
    
    // 打开调试窗口
    @objc fileprivate func toggleOpen()
    {
        if self.frame.maxY <= AntDebugBarButtonHeight
        {
            self.setNeedsLayout()
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(alphaAntButton), object: nil)
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(toggleClose), object: nil)
            UIView.animate(withDuration: 0.4, animations: {
                UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
                self.frame.origin.y = 0
                self.layoutIfNeeded()
                self.antBtn.alpha = 0
            }, completion: { (finished) in
                self.perform(#selector(self.toggleClose), with: nil, afterDelay: 4)
            })
        }
    }
    
    // 关闭调试窗口
    @objc fileprivate func toggleClose()
    {
        if self.frame.maxY > AntDebugBarButtonHeight
        {
            self.setNeedsLayout()
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(alphaAntButton), object: nil)
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(toggleOpen), object: nil)
            UIView.animate(withDuration: 0.4, animations: {
                UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
                self.frame.origin.y = -self.contentView.frame.size.height
                self.layoutIfNeeded()
            }, completion: { (finished) in
                self.perform(#selector(self.alphaAntButton), with: nil, afterDelay: 0.3)
            })
        }
    }
    
    @objc fileprivate func alphaAntButton()
    {
        UIView.animate(withDuration: 0.3){
            self.antBtn.alpha = 1
        }
    }
    
}

extension AntDebugBar
{
    // 切换到开发环境
    @objc fileprivate func changeApiEnvironmentToDEV(_ sender: UIButton)
    {
        print("开发环境")
    }
    
    // 切换到SIT环境
    @objc fileprivate func changeApiEnvironmentToSIT(_ sender: UIButton)
    {
        print("SIT环境")
    }
    
    // 切换到UAT环境
    @objc fileprivate func changeApiEnvironmentToUAT(_ sender: UIButton)
    {
        print("UAT环境")
    }
    
    // 切换到生产环境
    @objc fileprivate func changeApiEnvironmentToPRO(_ sender: UIButton)
    {
        print("生产环境")
    }
}
