//
//  GALogWindow.swift
//  AntDebug
//
//  Created by 刘伟 on 16/11/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import UIKit

let kGALogWindowHeight:CGFloat = 200

var gaLogWindow: GALogWindow?

class GALogWindow: UIView {
    
    private init() {
        super.init(frame: CGRect.zero)
        settingLayout()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func instance() -> GALogWindow
    {
        if gaLogWindow == nil
        {
            let screenSize = UIScreen.main.bounds.size
            let y = screenSize.height - kGALogWindowHeight - 50
            gaLogWindow = GALogWindow(frame: CGRect(x: 0, y: y, width: screenSize.width, height: kGALogWindowHeight))
            gaLogWindow?.isHidden = true
        }
        return gaLogWindow!
    }
    
    class func closeInstance()
    {
        gaLogWindow = nil
    }
    
    
    override var isHidden: Bool
    {
        get{
            return super.isHidden
        }
        set{
            super.isHidden = newValue
            if newValue
            {
                self.removeFromSuperview()
            }else{
                if self.superview == nil {
                    let window = UIApplication.shared.keyWindow
                    window?.addSubview(self)
                }
                self.superview!.bringSubview(toFront: self)
            }
        }
    }
    
    
    private func settingLayout() {
        self.backgroundColor = UIColor.purple
        
    }
    
    
    func showGAEvent(withCategory ca:String, action act:String, label lab:String, value val:String, extras ext:String)
    {
        
    }
    
    

}
