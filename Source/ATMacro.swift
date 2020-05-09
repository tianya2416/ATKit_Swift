//
//  ATMacro.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/5/9.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH    :CGFloat    = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT   :CGFloat    = UIScreen.main.bounds.size.height

let iPhone_X        : Bool      = ATMacro.iPhone_X();//is iPhoneX
let STATUS_BAR_HIGHT:CGFloat    = (iPhone_X ? 44: 20)//iPhoneX 44,other 20
let NAVI_BAR_HIGHT  :CGFloat    = (iPhone_X ? 88: 64)//iPhoneX 88,other 64
let TAB_BAR_ADDING  :CGFloat    = (iPhone_X ? 34 : 0)//iphoneX 34,other 0

class ATMacro : NSObject {
    class func iPhone_X() -> Bool{
        let window : UIWindow = ((UIApplication.shared.delegate?.window)!)!;
           if #available(iOS 11.0, *) {
               let inset : UIEdgeInsets = window.safeAreaInsets
               if inset.bottom == 34 || inset.bottom == 21 {
                   return true;
               }else{
                   return false
               }
           } else {
              return false;
           };
       }
}
