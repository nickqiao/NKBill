//
//  NKBaseTableViewCell.swift
//  NKBill
//
//  Created by nick on 16/6/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

public class NKBaseTableViewCell: UITableViewCell {

    static var identifier: String { return String.className(self) }
    
    private var bottomDottedLine : CAShapeLayer = {
        let dottedLine = CAShapeLayer()
        return dottedLine
    }()
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //layer.addSublayer(bottomDottedLine)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public override func awakeFromNib() {
    }
    
    public func setup() {
        
    }
    
    public class func height() -> CGFloat {
        return 64
    }
    
    public func setData(data: Any?) {
        self.backgroundColor = UIColor(hexString: "F1F8E9")
        self.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        self.textLabel?.textColor = UIColor(hexString: "9E9E9E")
        if let menuText = data as? String {
            self.textLabel?.text = menuText
        }
    }
    
    override public func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override public func setSelected(selected: Bool, animated: Bool) {
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
//        let mdotteShapePath = CGPathCreateMutable()
//        bottomDottedLine.fillColor = UIColor.clearColor().CGColor
//        bottomDottedLine.strokeColor = MACommonConstants.Color.cellBottomLineColor.CGColor
//        bottomDottedLine.lineWidth = 1.0
//        CGPathMoveToPoint(mdotteShapePath, nil, 0, CGRectGetHeight(bounds) - 1)
//        CGPathAddLineToPoint(mdotteShapePath, nil, CGRectGetWidth(bounds), CGRectGetHeight(bounds) - 1)
//        bottomDottedLine.path = mdotteShapePath
//        let arr :NSArray = NSArray(array: [2,1])
//        bottomDottedLine.lineDashPhase = 1.0
//        bottomDottedLine.lineDashPattern = arr as? [NSNumber]
    }

}
