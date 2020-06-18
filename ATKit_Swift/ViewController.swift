//
//  ViewController.swift
//  AppCategory
//
//  Created by wangws1990 on 2020/5/8.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableBtn : UIButton = {
        return UIButton.init(type: .custom)
    }()
    lazy var connectionBtn : UIButton = {
        return UIButton.init(type: .custom);
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ATMacro.iPhoneX())
        self.edgesForExtendedLayout = [];
        self.showNavTitle(title: "主页", back: false);
        self.view.addSubview(self.tableBtn);
        self.view.addSubview(self.connectionBtn);
        
        self.tableBtn.frame = CGRect.init(x: 0, y: 40, width: self.view.frame.size.width, height: 45);
        self.tableBtn.setTitle("table", for: .normal);
        self.tableBtn.backgroundColor = UIColor.red
        
        self.connectionBtn.frame = CGRect.init(x: 0, y: 150, width: self.view.frame.size.width, height: 45);
        self.connectionBtn.setTitle("connection", for: .normal);
        self.connectionBtn.backgroundColor = UIColor.red
        
        self.tableBtn.addTarget(self, action: #selector(tableAction), for: .touchUpInside);
        self.connectionBtn.addTarget(self, action: #selector(connectionAction), for: .touchUpInside);
    }
    @objc func tableAction(){
        let nvc = UINavigationController.init(rootViewController: AppTableViewController())
        self.present(nvc, animated: true, completion: nil) //UIViewController.rootTopPresentedController().navigationController?.pushViewController(AppTableViewController(), animated: true);
    }
    @objc func connectionAction(){
        UIViewController.rootTopPresentedController().navigationController?.pushViewController(AppConnectionController(), animated: true);
    }
}

