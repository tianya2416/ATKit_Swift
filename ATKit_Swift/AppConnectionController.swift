//
//  AppConnectionController.swift
//  AppCategory
//
//  Created by wangws1990 on 2020/5/8.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
let top : CGFloat  = 10;
class AppConnectionController: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        layout.scrollDirection = .vertical;
        return layout;
    }()
    lazy var collectionView : UICollectionView = {
        let collectionView : UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: self.layout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.isScrollEnabled = true;
        collectionView.backgroundColor = UIColor.white;
        collectionView.backgroundView?.backgroundColor = UIColor.white;
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = [];
        self.view.addSubview(self.collectionView);
        self.collectionView.frame = self.view.frame;
        self.showNavTitle(title: "collectionView")
    }
}
extension AppConnectionController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK:UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return top;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return top;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: top, bottom: top, right: top);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view : AppCollectionHeadView = AppCollectionHeadView.viewForCollectionView(collectionView: collectionView, elementKind: kind, indexPath: indexPath);
        let string = kind == UICollectionView.elementKindSectionHeader ? "Header" : "Footer";
        view.titleLab.text = string + String(indexPath.row + 1);
        return view;
    }
    //MARK:UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize.init(width: self.view.frame.size.width/3-15, height: 100)
//        return collectionView.sizeForCollectionView(classCell: AppCollectionViewCell.self, indexPath: indexPath, fixedValue: self.view.frame.size.width/3 - 15, dynamic: .width) { (cell) in
//
//        }
        return collectionView.sizeForCollectionView(classCell: AppCollectionViewCell.self, indexPath: indexPath, fixedValue: self.view.frame.size.width/3 - 15, dynamic: .width) { (cell) in
            cell.titleLab.text = "   "
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AppCollectionViewCell = AppCollectionViewCell.cellForCollectionView(collectionView:collectionView, indexPath: indexPath);
        cell.titleLab.text = "row" + String(indexPath.row + 1);
       // cell.titleLab.te
        return cell;
    }
    //MARK:UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
