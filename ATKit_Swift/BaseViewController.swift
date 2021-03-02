//
//  BaseViewController.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2021/2/3.
//  Copyright © 2021 wangws1990. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    deinit {
        print(self.classForCoder,"deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.prefersNavigationBarHidden = false
    }

}
