//
//  UICollectionViewCell+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
private var size_cache_key = 10000

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
    
    class func sizeForCollectionView(collectionView :UICollectionView,indexPath :IndexPath,fixedValue :CGFloat,dynamic :ATDynamic,config:((_ cell :UICollectionViewCell) ->Void)? = nil) ->CGSize{
        
        let cell = cellForCollectionView(collectionView: collectionView, indexPath: indexPath)
        let haveCache = cell.haveCache(indexPath: indexPath)
        if haveCache {
            let zeroValue = NSValue(cgSize: CGSize.zero)
            let sizeCache = cell.sizeCacheAtIndexPath(indexPath: indexPath)
            if sizeCache.isEqual(to: zeroValue) == false {
                return sizeCache.cgSizeValue
            }
        }
        if config != nil {
            config!(cell)
        }
        var  size = CGSize(width: fixedValue, height: fixedValue)
        if dynamic != ATDynamic.size {
            let att = dynamic == .width ? NSLayoutConstraint.Attribute.width : NSLayoutConstraint.Attribute.height
            let con = NSLayoutConstraint(item: cell.contentView, attribute: att, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: fixedValue)
            cell.contentView.addConstraint(con)
            size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            cell.contentView.removeConstraint(con)
        }else{
            size = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        }
        if cell.sizeCache.count > indexPath.section {
            let sizeValue = NSValue(cgSize: size)
            var sectionCache : [NSValue] = cell.sizeCache[indexPath.section]
            if haveCache {
                sectionCache[indexPath.row] = sizeValue
            }else{
                sectionCache.insert(sizeValue, at: indexPath.row)
            }
        }
        return size

    }
    private func sizeCacheAtIndexPath(indexPath :IndexPath) -> NSValue{
        let sizeValue = self.sizeCache[indexPath.section][indexPath.row]
        return sizeValue
    }
    private func haveCache(indexPath :IndexPath) -> Bool{
        var haveCache = false
        var sizeCache : [[NSValue]] = self.sizeCache
        if sizeCache.count > indexPath.section {
            haveCache = sizeCache[indexPath.section].count > indexPath.row ? true : false
        }else{
            var index = sizeCache.count
            while index < indexPath.section + 1 {
                sizeCache.append(contentsOf: [])
                index = index + 1
            }
        }
        return haveCache
    }
    private var sizeCache :[[NSValue]]{
        set{
            objc_setAssociatedObject(self, &size_cache_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }get{
            guard let datas = objc_getAssociatedObject(self, &size_cache_key) as? [[NSValue]] else { return [] }
            return datas
        }
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
