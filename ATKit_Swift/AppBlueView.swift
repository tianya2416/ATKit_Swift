//
//  AppBlueView.swift
//  ATKit_Swift
//
//  Created by wangws1990 on 2020/12/8.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit

class AppBlueView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.yellow
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
class AppRedView : UIView{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.red
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    func setName(){
        print("==================");
    }
}
