//
//  UIView+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

public extension UIView{
    class func xibName() -> String{
        let name :String = NSStringFromClass(self.classForCoder())
        let datas :[String] = name.components(separatedBy: ".")
        return datas.count > 0 ? datas.last! : ""
    }
    class func nibName() ->String {
        return xibName()
    }
    class func instanceView() -> Self{
        guard Bundle.main.url(forResource:nibName(), withExtension:"nib") != nil else { return self.init() }
        let view = Bundle.main.loadNibNamed(nibName(), owner:self, options: nil)?.first
        return view as! Self
    }
}
