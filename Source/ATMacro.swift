//
//  ATMacro.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/5/9.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import Foundation
import UIKit

public let SCREEN_WIDTH    :CGFloat    = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT   :CGFloat    = UIScreen.main.bounds.size.height

public let iPhoneX         : Bool       = ATMacro.iPhone_X();//is iPhoneX
public let STATUS_BAR_HIGHT:CGFloat    = (iPhoneX ? 44: 20)//iPhoneX 44,other 20
public let NAVI_BAR_HIGHT  :CGFloat    = (iPhoneX ? 88: 64)//iPhoneX 88,other 64
public let TAB_BAR_ADDING  :CGFloat    = (iPhoneX ? 34 : 0)//iphoneX 34,other 0

public class ATMacro : NSObject {
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
    class func imageWithColor(color:UIColor) -> UIImage{
          let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
          UIGraphicsBeginImageContext(rect.size)
          let context = UIGraphicsGetCurrentContext()
          context!.setFillColor(color.cgColor)
          context!.fill(rect)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return image!
      }
}
