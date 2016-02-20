//
//  NKIndexTableHeader.swift
//  NKBill
//
//  Created by nick on 16/2/20.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

protocol NKIndexTableHeaderDelegate {
    func indexTableHeaderPieChartButtonClicked()
    func indexTableHeaderBarChartButtonClicked()
}

class NKIndexTableHeader: UIView {

    var delegate: NKIndexTableHeaderDelegate?
    
    static func indexTableHeader() -> NKIndexTableHeader {
        return NSBundle.mainBundle().loadNibNamed("NKIndexTableHeader", owner: nil, options: nil).last as! NKIndexTableHeader
    }

    
    @IBAction func pieChartButtonClicked(sender: AnyObject) {
        delegate?.indexTableHeaderPieChartButtonClicked()
    }
    
    @IBAction func barChartButtonClicked(sender: AnyObject) {
        delegate?.indexTableHeaderBarChartButtonClicked()
    }
}
