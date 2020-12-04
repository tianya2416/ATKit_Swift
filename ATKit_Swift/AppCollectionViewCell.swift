//
//  AppCollectionViewCell.swift
//  AppCategory
//
//  Created by wangws1990 on 2020/5/8.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    lazy var dic: [String:UICollectionViewCell] = {
        return [:]
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.08);
        // Initialization code
    }

}
class AppCollectionHeadView : UICollectionReusableView{
    lazy var titleLab : UILabel = {
        return UILabel.init()
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    func loadUI(){
        self.backgroundColor = UIColor.red;
        self.titleLab.textAlignment = .center;
        self.addSubview(self.titleLab);
        self.titleLab.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30);
    }
}
