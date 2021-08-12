//
//  ATTabController.swift
//  ATKit_Swift
//
//  Created by 王炜圣 on 2021/8/12.
//  Copyright © 2021 wangws1990. All rights reserved.
//

import UIKit

class ATTabController: UITabBarController {

    private lazy var listData: [UIViewController] = {
        return [];
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let cases = ViewController()
        self.createCtrl(vc: cases, title:"书架", normal:"ic_tab_bookcase_n", select:"ic_tab_bookcase_s")
        let shop = HiddenController()
        self.createCtrl(vc: shop, title:"书城", normal:"ic_tab_bookshop_n", select:"ic_tab_bookshop_s")
        self.viewControllers = self.listData
        self.tabBar.tintColor = UIColor.black
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            // Fallback on earlier versions
        }
    }
    private func createCtrl(vc :UIViewController,title :String,normal: String,select :String) {
        let nv = BaseNavigationController(rootViewController: vc)
        vc.showNaviTitle(title: title)
        nv.tabBarItem.title = title
        nv.tabBarItem.image = UIImage()
        nv.tabBarItem.selectedImage = UIImage()
        nv.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.black,.font:UIFont.systemFont(ofSize: 12, weight: .regular)], for: .selected)
        nv.tabBarItem.setTitleTextAttributes([.foregroundColor : UIColor.gray,.font:UIFont.systemFont(ofSize: 12, weight: .regular)], for: .normal)
        self.listData.append(nv)
    }
}
