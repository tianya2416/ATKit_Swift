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
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .vertical;
        return layout;
    }()
    lazy var collectionView : UICollectionView = {
        let collectionView : UICollectionView = UICollectionView.init(frame:CGRect.zero, collectionViewLayout: self.layout);
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
        self.showNavTitle(title: "collectionView", back: true)
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
        let string = kind == UICollectionElementKindSectionHeader ? "Header" : "Footer";
        view.titleLab.text = string + String(indexPath.row + 1);
        return view;
    }
    //MARK:UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat((UIScreen.main.bounds.size.width - 4*top - 1)/3);
        return CGSize.init(width:width, height: 40);
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
