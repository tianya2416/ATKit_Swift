//
//  AppBlueView.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/8.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class AppBlueView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.yellow
    }
}
