//
//  UICollectionViewCell+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

public extension UICollectionViewCell{
    static var confiTag : Int = 32241981
    class func cellForCollectionView(collectionView:UICollectionView,indexPath : IndexPath) -> Self{
        return self.cellForCollectionView(collectionView: collectionView, indexPath: indexPath, identifier:nil, config: nil)
    }
    class func cellForCollectionView(collectionView:UICollectionView,indexPath: IndexPath,identifier:String? = nil,config:((_ cell :UICollectionViewCell) ->Void)? = nil) ->Self{
        let identy : String  = cellRegister(collectionView: collectionView, identifier: identifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:identy, for: indexPath)
        if cell.tag != confiTag {
            cell.tag = confiTag
            if (config != nil) {
                config!(cell)
            }
        }
        return cell as! Self
    }
    class func cellRegister(collectionView:UICollectionView,identifier :String? = nil) ->String{
        let identy : String = identifier != nil ? identifier! : NSStringFromClass(self.classForCoder())
        var res1 : Bool = false
        var res2 : Bool = false
        let dic1  = collectionView.value(forKeyPath: "cellNibDict")
        if dic1 != nil {
            let dic1 : NSDictionary = (dic1 as?  NSDictionary)!
            res1 = (dic1.value(forKeyPath:identy) != nil) ? true : false
        }
        let dic2  = collectionView.value(forKeyPath: "cellClassDict")
        if dic2 != nil {
            let dic2 : NSDictionary = (dic2 as? NSDictionary)!
            res2 = (dic2.value(forKeyPath: identy) != nil) ? true : false
        }
        let hasRegister : Bool = res1 || res2
        if hasRegister  == false {
            let nib =  Bundle.main.url(forResource:self.xibName(), withExtension:"nib")
            if (nib != nil) {
              collectionView.register(UINib(nibName: self.xibName(), bundle: nil), forCellWithReuseIdentifier: identy)
            }else{
                collectionView.register(self.classForCoder(), forCellWithReuseIdentifier: identy)
            }
        }
        return identy
    }
}
public extension UICollectionReusableView{
    static var configTag : Int = 32241982;
    class func viewForCollectionView(collectionView:UICollectionView,elementKind:String,indexPath:IndexPath) ->Self{
        return self.viewForCollectionView(collectionView: collectionView, elementKind: elementKind, indexPath: indexPath, identifier: nil, config: nil)
    }
    class func viewForCollectionView(collectionView:UICollectionView,elementKind:String,indexPath:IndexPath,identifier:String? = nil,config:((_ cell :UICollectionReusableView) ->Void)? = nil) ->Self {
        assert(elementKind.count > 0)
        let identy = viewRegister(collectionView: collectionView, elementKind: elementKind, indexPath: indexPath, identifier: identifier)
        let cell : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identy, for: indexPath)
        if cell.tag != configTag{
            cell.tag = configTag
            if config != nil {
                config!(cell)
            }
        }
        return cell as! Self
    }
    class func viewRegister(collectionView:UICollectionView,elementKind:String,indexPath:IndexPath,identifier:String? = nil) ->String{
        let identy : String = identifier != nil ? identifier! : NSStringFromClass(self.classForCoder())
        let keyPath = elementKind.appendingFormat("/" + identy)
        var res1 : Bool = false
        var res2 : Bool = false
        let dic1 = collectionView.value(forKeyPath:"supplementaryViewNibDict")
        if  dic1 != nil {
            let dic  = dic1 as! NSDictionary
            res1 = dic.value(forKeyPath:keyPath) != nil ? true : false
        }
        let dic2 = collectionView.value(forKeyPath:"supplementaryViewClassDict")
        if dic2 != nil {
            let dic  = dic2 as! NSDictionary
            res2 = dic.value(forKeyPath:keyPath) != nil ? true : false
        }
        let hasRegister = res1 || res2
        if hasRegister == false {
            let nib =  Bundle.main.url(forResource:self.xibName(), withExtension:"nib")
            if (nib != nil) {
                collectionView.register(UINib(nibName: self.xibName(), bundle:nil), forSupplementaryViewOfKind: elementKind, withReuseIdentifier:identy)
            }else{
                collectionView.register(self.classForCoder(), forSupplementaryViewOfKind: elementKind, withReuseIdentifier:identy)
            }
        }
        return identy
    }
}

