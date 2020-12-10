//
//  AppMainView.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/3.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class AppMainView: UIView {
    @IBOutlet weak var blueView: AppBlueView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.blueView.backgroundColor = UIColor.red
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
