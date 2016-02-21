//
//  NKIconLabel.swift
//  NKBill
//
//  Created by nick on 16/2/21.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKIconLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup(){
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.flatGrayColorDark().CGColor
        layer.masksToBounds = true
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
}
