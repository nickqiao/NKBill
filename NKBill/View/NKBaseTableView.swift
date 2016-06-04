//
//  NKBaseTableView.swift
//  NKBill
//
//  Created by nick on 16/6/4.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKBaseTableView: UITableView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = .None
    }

}
