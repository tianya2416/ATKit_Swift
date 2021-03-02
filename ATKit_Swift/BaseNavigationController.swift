//
//  BaseNavigationController.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2021/1/26.
//  Copyright © 2021 wangws1990. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

}
extension BaseNavigationController : UINavigationControllerDelegate,UIGestureRecognizerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        let show = viewController.prefersNavigationBarHidden
        self.interactivePopGestureRecognizer?.delegate = self
        self.setNavigationBarHidden(show, animated: animated)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.children.count > 1
    }
}
