//
//  ViewController.swift
//  AntDebug
//
//  Created by 刘伟 on 16/11/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(_ sender: Any) {
        GALogWindow.instance().showGAEvent(withCategory: "测试分类", action: "测试Action", label: "测试label", value: 0, extras: "很长很长很长很长很长很长很长很长很长很长很长很长很长很长")
    }

}

