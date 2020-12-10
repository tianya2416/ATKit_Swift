//
//  UIViewController+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
private let backIcon  = "icon_nav_back"
private let closeIcon = "icon_nav_close"

@objc extension UIViewController{
    open func showNavTitle(title : String?){
        self.showNavTitle(title: title,backIcon: backIcon)
    }
    open func showNavTitle(title :String?,backIcon :String?){
        self.navigationItem.title = title ?? ""
        if backIcon != nil {
            let image = UIImage(named: backIcon!)
            self.setBackItem(backItem:image)
        }else{
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.hidesBackButton = true
        }
    }
    open func setBackItem(backItem:UIImage?){
        let image = UIImage(named: closeIcon)
        self.setBackItem(backItem: backItem, closeItem:image)
    }
    open func setBackItem(backItem:UIImage?,closeItem:UIImage?){
        if self.navigationController != nil {
            if self.navigationController?.viewControllers.count == 1 && (self.presentingViewController != nil) {
                self.navigationItem.leftBarButtonItem = self.navItem(rightItem:false, image: closeItem , title:(closeItem != nil) ? nil:"ㄨ", color:nil, target:self, action: #selector(goBack))
            }else if((self.navigationController?.viewControllers.count)! > 1 || (!(self.navigationController != nil) && !(self.parent != nil))){
                self.navigationItem.leftBarButtonItem = self.navItem(rightItem:false, image: backItem , title:(backItem != nil) ? nil:"ㄑ", color:nil, target:self, action: #selector(goBack))
            }else{
                self.navigationItem.leftBarButtonItem = nil
                self.navigationItem.hidesBackButton = true
            }
            if self.navigationItem.leftBarButtonItem?.customView != nil {
                let button:UIButton = (self.navigationItem.leftBarButtonItem?.customView as? UIButton)!
                button.contentHorizontalAlignment = .left
            }
        }
    }
    @objc open func goBack(){
        self.back(animated:true)
    }
    @objc open func back(animated:Bool){
        if self.navigationController?.viewControllers != nil {
            if (self.navigationController?.viewControllers.count)! > 1{
                self.navigationController?.popViewController(animated: animated)
            }else if self.presentingViewController != nil {
                self.dismiss(animated: animated, completion: nil)
                self.view.endEditing(true)
            }
        }else{
            if self.presentingViewController != nil {
                self.dismiss(animated: animated, completion: nil)
                self.view.endEditing(true)
            }
        }
    }
    open func dismissOrPopToRootControlelr(){
        self.dismissOrPopToRootController(animated: true)
    }
    open func dismissOrPopToRootController(animated : Bool){
        if (self.presentingViewController != nil) {
            self.dismiss(animated:animated, completion: nil)
        }else if (self.navigationController?.viewControllers.count) != nil{
            if (self.navigationController?.viewControllers.count)! > 1 {
                self.navigationController?.popToRootViewController(animated: animated);
            }
        }
    }
    open func navItem(rightItem :Bool,image:UIImage?,title:String?,color:UIColor?,target: Any?,action:Selector) -> UIBarButtonItem{
        let button:UIButton = UIButton(type: .custom)
        button.addTarget(target, action:action, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setImage(image ?? UIImage(), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        button.setTitleColor((color != nil) ? color : UIColor.gray, for: .normal)
        button.contentHorizontalAlignment = rightItem ? UIControl.ContentHorizontalAlignment.right : UIControl.ContentHorizontalAlignment.left
        return UIBarButtonItem(customView: button)
    }
    open func setNavRightItem(image:UIImage?,title:String?,color:UIColor?,action:Selector){
        self.navigationItem.rightBarButtonItem = self.navItem(rightItem:true, image: image, title: title, color: color, target:self, action:action)
    }
    
    open class func rootTopPresentedController()-> UIViewController{
        return self.rootTopPresentedControllerWihtKeys(keys: nil)
    }
    open class func rootTopPresentedControllerWihtKeys(keys :[String]? = nil) ->UIViewController{
        let window : UIWindow = (UIApplication.shared.delegate?.window)!!
        return (window.rootViewController?.topPresentedControllerWihtKeys(keys: keys))!
    }
    open func topPresentedController()->UIViewController{
        return self.topPresentedControllerWihtKeys(keys:nil)
    }
    open func topPresentedControllerWihtKeys(keys:[String]? = nil)->UIViewController{
        let top : [String] = (keys != nil) ? keys! : ["centerViewController", "contentViewController"]
        var rootVC : UIViewController = self;
        if rootVC is UITabBarController {
            let tabVC : UITabBarController = rootVC as! UITabBarController
            let vc = tabVC.selectedViewController != nil ? tabVC.selectedViewController : tabVC.children.first
            if vc != nil {
                return vc!.topPresentedControllerWihtKeys(keys: top)
            }
        }
        for str in top{
            if rootVC.responds(to: NSSelectorFromString(str)) {
                let vc  = rootVC.perform(NSSelectorFromString(str))
                let ct = vc?.takeUnretainedValue()
                if ct is UIViewController {
                    let ctrl : UIViewController = ct as! UIViewController
                    return ctrl.topPresentedControllerWihtKeys(keys: top)
                }
            }
        }
        while rootVC.presentedViewController != nil && rootVC.presentedViewController?.isBeingDismissed == false {
            rootVC = rootVC.presentedViewController!
        }
        if rootVC is UINavigationController {
            let nvc : UINavigationController = rootVC as! UINavigationController
            rootVC = nvc.topViewController!
        }
        return rootVC
    }
    open class func vcFromStoryBoard(storyBoard :String,identifier :String) -> UIViewController{
        let sbName : String = storyBoard.count > 0 ? storyBoard : NSStringFromClass(self)
        let theId  : String = identifier.count > 0 ? storyBoard : NSStringFromClass(self)
        let story = UIStoryboard(name: sbName, bundle: nil)
        
        let controller = story.instantiateViewController(withIdentifier: theId)
        return controller
    }
}
