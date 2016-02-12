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
       
        let p3 = NKPlatform()
        p3.name = "陆金所"
        let p4 = NKPlatform()
        p4.name = "积木盒子"
        let p5 = NKPlatform()
        p5.name = "人人贷"
        let p6 = NKPlatform()
        p6.name = "团贷网"
        let p7 = NKPlatform()
        p7.name = "PPMoney"
        let p8 = NKPlatform()
        p8.name = "果树财富"
        let p9 = NKPlatform()
        p9.name = "人人聚财"
        let p10 = NKPlatform()
        p10.name = "红岭创投"
        let p11 = NKPlatform()
        p11.name = "顺发人人帮"
      
        addPlatform(p3)
        addPlatform(p11)
        addPlatform(p4)
        addPlatform(p5)
        addPlatform(p6)
        addPlatform(p7)
        addPlatform(p8)
        addPlatform(p9)
        addPlatform(p10)
        
        
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
