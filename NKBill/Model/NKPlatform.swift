//
//  NKCompany.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKPlatform: NSObject,NSCoding {
    
    var name: String = ""
    var icon: String = ""
    
    override init() {
        super.init()
    }
    
    init(name:String,icon:String) {
        self.name = name
        self.icon = icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.icon = aDecoder.decodeObjectForKey("icon") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(icon, forKey: "icon")
    }
    
    override var description: String {
        return "name:\(name)" +
                "icon:\(icon)"
    }
}
