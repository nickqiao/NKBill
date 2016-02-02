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
    
    private var platforms: [NKPlatform] = []
    
    let realm = try! Realm()
    
    override init() {
        super.init()
    }
    
    func createPlaceholderPlatform() {
        let p1 = NKPlatform(value:["支付宝",[]])
        let p2 = NKPlatform(value:["陆金所",[]])
        let p3 = NKPlatform(value:["积木盒子",[]])
        let p4 = NKPlatform(value:["人人贷",[]])
        platforms = [p1,p2,p3,p4]
        savePlatforms()
    }
    
    func getPlatforms() -> [NKPlatform]{
        if self.realm.objects(NKPlatform).count == 0 {
            createPlaceholderPlatform()
            return platforms
        }else {
            platforms.removeAll()
            self.realm.objects(NKPlatform).forEach({platforms.append($0)})
            return platforms
        }
        
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
    
    func savePlatforms() {
        try! realm.write({ () -> Void in
            platforms.forEach({realm.add($0)})
        })
    }
    
}
