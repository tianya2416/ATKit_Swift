//
//  UIViewController+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

@objc extension UIViewController{
    ///MARK:push    就会显示backIcon
    ///MARK:present 就会显示closeIcon
    open func showNaviTitle(title :String?,backIcon :String = "icon_nav_back",closeIcon :String = "icon_nav_close"){
        self.navigationItem.title = title ?? ""
        let backItem  = UIImage(named: backIcon)
        let closeItem = UIImage(named: closeIcon)
        self.setBackItem(backItem: backItem, closeItem:closeItem)
    }
    open func setBackItem(backItem:UIImage?,closeItem:UIImage?){
        guard let navigationController = self.navigationController else { return }
        if navigationController.viewControllers.count == 1 && self.presentingViewController != nil {
            self.navigationItem.leftBarButtonItem = self.navItem(rightItem:false, image: closeItem , title:(closeItem != nil) ? nil:"ㄨ", color:nil, target:self, action: #selector(goBack))
        }else if(navigationController.viewControllers.count > 1 || !(self.parent != nil)){
            self.navigationItem.leftBarButtonItem = self.navItem(rightItem:false, image: backItem , title:(backItem != nil) ? nil:"ㄑ", color:nil, target:self, action: #selector(goBack))
        }else{
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.hidesBackButton = true
        }
        if let button = self.navigationItem.leftBarButtonItem?.customView as? UIButton {
            button.contentHorizontalAlignment = .left
        }
    }
    open func setNavRightItem(image:UIImage?,title:String?,color:UIColor?,action:Selector){
        self.navigationItem.rightBarButtonItem = self.navItem(rightItem:true, image: image, title: title, color: color, target:self, action:action)
    }
    open func navItem(rightItem :Bool,image:UIImage?,title:String?,color:UIColor?,target: Any?,action:Selector) -> UIBarButtonItem{
        let button = UIButton(type: .custom)
        button.addTarget(target, action:action, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setImage(image ?? UIImage(), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        button.setTitleColor(color ?? UIColor.gray, for: .normal)
        button.contentHorizontalAlignment = rightItem ? .right : .left
        return UIBarButtonItem(customView: button)
    }
    @objc open func goBack(){
        self.back(animated:true)
    }
    @objc open func back(animated:Bool){
        if let viewControllers = self.navigationController?.viewControllers{
            if viewControllers.count > 1{
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
        }else if let viewControllers = self.navigationController?.viewControllers{
            if viewControllers.count > 1 {
                self.navigationController?.popToRootViewController(animated: animated);
            }
        }
    }
    open class func rootTopPresentedController()-> UIViewController{
        guard let window = UIApplication.shared.delegate?.window else { return UIViewController() }
        guard let vc = window?.rootViewController?.topPresentedController() else { return UIViewController() }
        return vc
    }
    open func topPresentedController() ->UIViewController{
        return self.rootTopPresentedController()
    }
    open func rootTopPresentedController() -> UIViewController{
        var rootVC : UIViewController = self
        if let tabVC = rootVC as? UITabBarController {
            if let vc = tabVC.selectedViewController{
                return vc.rootTopPresentedController()
            }
            if let vc = tabVC.children.first {
                return vc.rootTopPresentedController()
            }
        }
        while rootVC.presentedViewController != nil && rootVC.presentedViewController?.isBeingDismissed == false {
            rootVC = rootVC.presentedViewController!
        }
        if let nvc = rootVC as? UINavigationController{
            if let top = nvc.topViewController {
                rootVC = top
            }
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
