//
//  AppDelegate.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/5/9.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var makeOrientation :UIInterfaceOrientation?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible();
        self.window?.backgroundColor = UIColor.white;
        let nvc = UINavigationController.init(rootViewController: ViewController.init());
        self.window?.rootViewController = nvc;
        return true
    }


}

