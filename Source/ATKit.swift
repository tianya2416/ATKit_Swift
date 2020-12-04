//
//  ATKit.swift
//  MySwiftObject
//
//  Created by wangws1990 on 2019/9/25.
//  Copyright © 2019 wangws1990. All rights reserved.
//

import UIKit

public enum ATDynamic {
    case width
    case height
    case size
}
private let at_iphone                 = ATKit.iPhone_Bar()
public class ATKit : NSObject {
    public class func at_iphoneX() -> Bool{
        return at_iphone.iphoneX
    }
    public class func at_statusBar() ->CGFloat{
        return at_iphone.statusBar
    }
    public class func at_naviBar() ->CGFloat{
        return (at_iphone.statusBar + 44)
    }
    public class func at_tabBar() ->CGFloat{
        return at_iphone.tabBar
    }
    class func iPhone_Bar() ->(iphoneX :Bool,statusBar : CGFloat,tabBar : CGFloat){
        if let window = UIApplication.shared.delegate?.window {
            if #available(iOS 11.0, *) {
                let inset : UIEdgeInsets = window!.safeAreaInsets
                return (inset.bottom > 0, inset.top,inset.bottom)
            } else {
                 return (false,20,0)
            }
        }
        return (false,20,0)
    }
    public class func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {return}
        
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}

