//
//  UICollectionView+ATKit.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/4.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
private var size_cache_key = 10000
private var cell_cache_key = 10001
public extension UICollectionView{
    //MARK: swizzling init
    static let initializeMethod: Void = {
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(reloadData), swizzledSelector: #selector(at_reloadData))
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(reloadSections(_:)), swizzledSelector: #selector(at_reloadSections(_:)))
        
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(deleteSections(_:)), swizzledSelector: #selector(at_deleteSections(_:)))
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(moveSection(_:toSection:)), swizzledSelector: #selector(at_moveSection(_:toSection:)))
        
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(reloadItems(at:)), swizzledSelector: #selector(at_reloadItems(_:)))
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(deleteItems(at:)), swizzledSelector: #selector(at_deleteItems(_:)))
        
        ATKit.swizzlingForClass(UICollectionView.self, originalSelector: #selector(moveItem(at:to:)), swizzledSelector: #selector(at_moveItem(_:to:)))
    }()
    //MARK:about size 使用该方法需要在AppDelegate初始化UICollectionView.initializeMethod
    func sizeForCollectionView<T:UICollectionViewCell>(classCell :T.Type,indexPath :IndexPath,fixedValue :CGFloat,dynamic :ATDynamic,config:((_ cellss :T) ->Void)? = nil) ->CGSize{
        if self.sizeCache == nil {
            self.sizeCache = []
        }
        if self.cellCache == nil {
            self.cellCache = [:]
            
        }
        let cache = self.haveCache(indexPath: indexPath)
        if cache {
            let zeroValue = NSValue(cgSize: CGSize.zero)
            let sizeCache = self.sizeCacheAtIndexPath(indexPath: indexPath)
            if sizeCache.isEqual(to: zeroValue) == false {
                return sizeCache.cgSizeValue
            }
        }
        let cell = at_cellForClassCell(classCell: classCell)
        if config != nil {
            config!(cell as! T)
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
                sectionCache.insert(sizeValue, at: indexPath.row)
               // sectionCache.append(sizeValue)
            }
            self.sizeCache![indexPath.section] = sectionCache
        }
        return size

    }
    //MARK:about cache
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
    //MARK:about cell
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
    private var cellCache: [String:UICollectionViewCell]? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &(cell_cache_key), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get {
            return objc_getAssociatedObject(self, &(cell_cache_key)) as? [String : UICollectionViewCell]
        }
    }
    private func at_cellForClassCell<T:UICollectionViewCell>(classCell :T.Type) -> UICollectionViewCell{
        let identy : String = at_registerForClassCell(classCell: classCell)
        let tempCell :[String : UICollectionViewCell] = self.cellCache!
        var cell = tempCell[identy]
        if cell == nil {
            let dic1  = self.value(forKeyPath: "cellNibDict")
            if dic1 != nil {
                let dic1 : NSDictionary = (dic1 as?  NSDictionary)!
                let nib = dic1[identy]
                if  nib is UINib {
                    let newNib = nib as! UINib
                    cell = (newNib.instantiate(withOwner: nil, options: nil).last as! UICollectionViewCell)
                    self.cellCache?.updateValue(cell!, forKey: identy)
                }
            }
        }
        return cell!
    }
    private func at_registerForClassCell<T:UICollectionViewCell>(classCell :T.Type) ->String{
        return classCell.cellRegister(collectionView: self, identifier: nil)
    }
    
    //MARK:about replace
    @objc private func at_reloadData(){
        self.sizeCache?.removeAll()
        self.at_reloadData()
    }
    @objc private func at_reloadSections(_ sections : IndexSet){
        sections.forEach { (index) in
            if (index < self.sizeCache!.count){
                self.sizeCache![index] = []
            }
        }
        self.at_reloadSections(sections)
    }
    @objc private func at_deleteSections(_ sections : IndexSet){
        sections.forEach { (index) in
            if(self.sizeCache!.count > index){
                self.sizeCache?.remove(at: index)
            }
        }
        self.at_deleteSections(sections)
    }
    @objc private func at_moveSection(_ sections : Int,toSection :Int){
        if self.sizeCache!.count > sections && self.sizeCache!.count > toSection {
            (self.sizeCache![sections],self.sizeCache![toSection]) = (self.sizeCache![toSection],self.sizeCache![sections])
        }
        self.at_moveSection(sections, toSection: toSection)
    }
    @objc private func at_reloadItems(_ indexPaths :[IndexPath]){
        indexPaths.forEach { (indexPath) in
            if(self.sizeCache!.count > indexPath.section){
                var sections = self.sizeCache![indexPath.section]
                if sections.count > indexPath.row {
                    sections[indexPath.row] = NSValue(cgSize: CGSize.zero)
                    self.sizeCache![indexPath.section] = sections
                }
            }
        }
        self.at_reloadItems(indexPaths)
    }
    @objc private func at_deleteItems(_ indexPaths :[IndexPath]){
        indexPaths.forEach { (indexpath) in
            if self.sizeCache!.count > indexpath.section{
                var sections = self.sizeCache![indexpath.section]
                if sections.count > indexpath.row {
                    sections.remove(at: indexpath.row)
                    self.sizeCache![indexpath.section] = sections
                }
            }
        }
        self.at_deleteItems(indexPaths)
    }
    @objc private func at_moveItem(_ indexPaths :IndexPath,to :IndexPath){
        if self.haveCache(indexPath: indexPaths) && self.haveCache(indexPath: to) {
            let indexPathSizeValue = self.sizeCacheAtIndexPath(indexPath: indexPaths)
            let newIndexPathSizeValue = self.sizeCacheAtIndexPath(indexPath: to)
            if self.sizeCache!.count > indexPaths.section && self.sizeCache!.count > to.section {
                var section1 = self.sizeCache![indexPaths.section]
                var section2 = self.sizeCache![to.section]
                section1[indexPaths.row] = newIndexPathSizeValue
                section2[to.row] = indexPathSizeValue
                self.sizeCache![indexPaths.section] = section1
                self.sizeCache![to.section] = section2;
            }
        }
        self.at_moveItem(indexPaths, to: to)
    }
}
