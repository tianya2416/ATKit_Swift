//
//  UICollectionViewCell+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
private var size_cache_key = 10000
private var cell_cache_key = 10001

public extension UICollectionViewCell{
    static var confiTag : Int = 32241981
    class func cellForCollectionView(collectionView:UICollectionView,indexPath : IndexPath) -> Self{
        return self.cellForCollectionView(collectionView: collectionView, indexPath: indexPath, identifier:nil, config: nil)
    }
    class func cellForCollectionView(collectionView:UICollectionView,indexPath: IndexPath,identifier:String? = nil,config:((_ cell :UICollectionViewCell) ->Void)? = nil) ->Self{
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:identy, for: indexPath)
        if cell.tag != confiTag {
            cell.tag = confiTag
            if (config != nil) {
                config!(cell)
            }
        }
        return cell as! Self
    }
}
public extension UICollectionReusableView{
    static var configTag : Int = 32241982;
    class func viewForCollectionView(collectionView:UICollectionView,elementKind:String,indexPath:IndexPath) ->Self{
        return self.viewForCollectionView(collectionView: collectionView, elementKind: elementKind, indexPath: indexPath, identifier: nil, config: nil)
    }
    class func viewForCollectionView(collectionView:UICollectionView,elementKind:String,indexPath:IndexPath,identifier:String? = nil,config:((_ cell :UICollectionReusableView) ->Void)? = nil) ->Self {
        assert(elementKind.count > 0)
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
        let cell : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identy, for: indexPath)
        if cell.tag != configTag{
            cell.tag = configTag
            if config != nil {
                config!(cell)
            }
        }
        return cell as! Self
    }
}
public extension UICollectionView{
    func sizeForCollectionView<T:UICollectionViewCell>(classCell :T.Type,indexPath :IndexPath,fixedValue :CGFloat,dynamic :ATDynamic,config:((_ cellss :UICollectionViewCell) ->Void)? = nil) ->CGSize{
        if self.sizeCache == nil {
            self.sizeCache = []
        }
        let cache = self.haveCache(indexPath: indexPath)
        if cache {
            let zeroValue = NSValue(cgSize: CGSize.zero)
            let sizeCache = self.sizeCacheAtIndexPath(indexPath: indexPath)
            if sizeCache.isEqual(to: zeroValue) == false {
                return sizeCache.cgSizeValue
            }
        }
        let cell = classCell.cellForCollectionView(collectionView: self, indexPath: indexPath)
        if config != nil {
            config!(cell)
        }
        var  size = CGSize(width: fixedValue, height: fixedValue)
        if dynamic != ATDynamic.size {
            let attribute = dynamic == .width ? NSLayoutConstraint.Attribute.width : NSLayoutConstraint.Attribute.height
            let con = NSLayoutConstraint(item: cell.contentView, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: fixedValue)
            cell.contentView.addConstraint(con)
            size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            cell.contentView.removeConstraint(con)
        }else{
            size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        }
        if self.sizeCache!.count > indexPath.section {
            let sizeValue = NSValue(cgSize: size)
            var sectionCache : [NSValue] = self.sizeCache![indexPath.section]
            if cache {
                sectionCache[indexPath.row] = sizeValue
            }else{
                sectionCache.append(sizeValue)
            }
            self.sizeCache![indexPath.section] = sectionCache
        }
        return size

    }
//    private func registerIdentify<T:UICollectionViewCell>(classCell : T.Type,indexPath :IndexPath) ->UICollectionViewCell{
//        let identy : String =  NSStringFromClass(classCell.classForCoder())
//        print("registerIdentify : ",identy)
//        var res1 : Bool = false
//        var res2 : Bool = false
//        let dic1  = self.value(forKeyPath: "cellNibDict")
//        if dic1 != nil {
//            let dic1 : NSDictionary = (dic1 as?  NSDictionary)!
//            res1 = (dic1.value(forKeyPath:identy) != nil) ? true : false
//        }
//        let dic2  = self.value(forKeyPath: "cellClassDict")
//        if dic2 != nil {
//            let dic2 : NSDictionary = (dic2 as? NSDictionary)!
//            res2 = (dic2.value(forKeyPath: identy) != nil) ? true : false
//        }
//        let hasRegister : Bool = res1 || res2
//        if hasRegister  == false {
//            let nib =  Bundle.main.url(forResource:identy, withExtension:"nib")
//            if (nib != nil) {
//              self.register(UINib(nibName:identy, bundle: nil), forCellWithReuseIdentifier: identy)
//            }else{
//                self.register(classCell.classForCoder(), forCellWithReuseIdentifier: identy)
//            }
//        }
//        let cell = self.dequeueReusableCell(withReuseIdentifier:identy, for: indexPath)
//        return cell
//    }


    private func sizeCacheAtIndexPath(indexPath :IndexPath) -> NSValue{
        let sizeValue = self.sizeCache![indexPath.section][indexPath.row]
        return sizeValue
    }
    private func haveCache(indexPath :IndexPath) -> Bool{
        var haveCache = false
        if self.sizeCache!.count > indexPath.section {
            haveCache = self.sizeCache![indexPath.section].count > indexPath.row ? true : false
        }else{
            var index = self.sizeCache!.count
            while index < indexPath.section + 1 {
                let listCaches : [NSValue] = []
                self.sizeCache!.append(listCaches)
                index = index + 1
            }
        }
        return haveCache
    }
    
    private var sizeCache: [[NSValue]]? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &(size_cache_key), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get {
            return objc_getAssociatedObject(self, &(size_cache_key)) as? [[NSValue]]
        }
    }
}
