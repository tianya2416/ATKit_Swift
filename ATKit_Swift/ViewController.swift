//
//  ViewController.swift
//  AppCategory
//
//  Created by wangws1990 on 2020/5/8.
//  Copyright © 2020 wangws1990. All rights reserved.
//
//s.source_files     = 'Source/*.swift'
import UIKit

class ViewController: BaseViewController {
    lazy var tableBtn : UIButton = {
        return UIButton.init(type: .custom)
    }()
    lazy var connectionBtn : UIButton = {
        return UIButton.init(type: .custom);
    }()
    lazy var mainView : AppMainView = {
        return AppMainView.instanceView()
    }()
    lazy var redView : AppRedView = {
        return AppRedView.instanceView()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = [];
        self.showNaviTitle(title: "主页");
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
        
        self.view.addSubview(self.mainView)
        self.mainView.frame = CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 200)
        
        self.view.addSubview(self.redView)
        self.redView.frame = CGRect(x: 0, y: 450, width: self.view.frame.size.width, height: 100)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @objc func tableAction(){
//        UIViewController.rootTopPresentedController().navigationController?.pushViewController(AppTableViewController(), animated: true)
        let root = UIViewController.rootTopPresentedController()
        let nvc = UINavigationController.init(rootViewController: AppTableViewController())
        root.present(nvc, animated: true, completion: nil)
    }
    @objc func connectionAction(){
        UIViewController.rootTopPresentedController().navigationController?.pushViewController(AppConnectionController(), animated: true);
    }
}

