//
//  UITableViewCell+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

public extension UITableViewCell{
    static var confiTag : Int = 32241983
    class func cellForTableView(tableView:UITableView,indexPath:IndexPath) ->Self{
       return self.cellForTableView(tableView: tableView, indexPath: indexPath, identifier: nil, config: nil)
    }
    class func cellForTableView(tableView:UITableView,indexPath:IndexPath,identifier:String? = nil,config:((_ cell :UITableViewCell) ->Void)? = nil) ->Self{
        let identy : String = identifier != nil ? identifier! : NSStringFromClass(self.classForCoder())
        var cell = tableView.dequeueReusableCell(withIdentifier: identy)
        if cell == nil {
            let nib =  Bundle.main.url(forResource:self.xibName(), withExtension:"nib")
            if (nib != nil) {
                tableView.register(UINib(nibName:self.xibName(), bundle:nil), forCellReuseIdentifier: identy)
            }else{
                tableView.register(self.classForCoder(), forCellReuseIdentifier: identy)
            }
            cell = tableView.dequeueReusableCell(withIdentifier:identy)
        }
        if cell?.tag != confiTag {
            cell?.tag = confiTag
            if (config != nil) {
                config!(cell!)
            }
        }
        return cell as! Self
    }
}
