//
//  NKPlatformManager.swift
//  NKBill
//
//  Created by nick on 16/1/31.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift

class NKPlatformManager: NSObject {
        
    //let realm = try! Realm()
    
    override init() {
        super.init()
    }
    
    func createPlaceholderPlatform() {
        let p1 = NKPlatform(value:["支付宝",[]])
        let p2 = NKPlatform(value:["陆金所",[]])
        let p3 = NKPlatform(value:["积木盒子",[]])
        let p4 = NKPlatform(value:["人人贷",[]])
        addPlatform(p1)
        addPlatform(p2)
        addPlatform(p3)
        addPlatform(p4)
    }
    
    func getInvestedPlatforms() -> Results<NKPlatform> {
        return realm.objects(NKPlatform).filter("accounts.@count > 0")
    }
    
    func getPlatforms() -> Results<NKPlatform> {
        if realm.objects(NKPlatform).count == 0 {
            createPlaceholderPlatform()
        }
        return realm.objects(NKPlatform)
    }
    
    func addPlatform(platform: NKPlatform) {
        try! realm.write({ () -> Void in
            realm.add(platform)
        })
    }
    
    func deleteplatform(platform: NKPlatform) {
        try! realm.write({ () -> Void in
            realm.delete(platform)
        })
    }
    
    

    
}
