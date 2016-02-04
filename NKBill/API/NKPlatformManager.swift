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
        
    let realm = try! Realm()
    
    override init() {
        super.init()
    }
    
    func createPlaceholderPlatform() {
        let p1 = NKPlatform()
        p1.name = "腾讯"
        let p2 = NKPlatform()
        p2.name = "阿里"
        let p3 = NKPlatform()
        p3.name = "百度"
        let p4 = NKPlatform()
        p4.name = "苹果"
        addPlatform(p1)
        addPlatform(p2)
        addPlatform(p3)
        addPlatform(p4)
    }
    
    func getInvestedPlatforms() -> Results<NKPlatform> {
        return realm.objects(NKPlatform).filter("accounts.@count > 0").sorted("sum", ascending: false)
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
            
            platform.accounts.forEach( {realm.delete($0.items)} )
            realm.delete(platform.accounts)
            realm.delete(platform)
            
        })
    }
   
}
