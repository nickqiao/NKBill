//
//  NKPlatformManager.swift
//  NKBill
//
//  Created by nick on 16/1/31.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKPlatformManager: NSObject {
    
    private var platforms: [NKPlatform] = []
    
    override init() {
        super.init()
        if let data = NSData(contentsOfFile: NSHomeDirectory().stringByAppendingString("/Documents/platform.bin")) {
            let unarchiveAlbums = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [NKPlatform]?
            if let unwrappedAlbum = unarchiveAlbums {
                platforms = unwrappedAlbum
            }
        } else {
            createPlaceholderPlatform()
        }

    }
    
    func createPlaceholderPlatform() {
        let p1 = NKPlatform(name: "支付宝", icon: "")
        let p2 = NKPlatform(name: "人人贷", icon: "")
        let p3 = NKPlatform(name: "陆金所", icon: "")
        let p4 = NKPlatform(name: "积木盒子", icon: "")
        platforms = [p1,p2,p3,p4]
        savePlatforms()
    }
    
    func getPlatforms() -> [NKPlatform]{
        
        return platforms
    }
    
    func addPlatform(plarform: NKPlatform,index: Int) {
        if platforms.count >= index {
            platforms.insert(plarform, atIndex: index)
        }else {
            platforms.append(plarform)
        }
    }
    
    func deleteplatformAtIndex(index:Int) {
        platforms.removeAtIndex(index)
    }
    
    func savePlatforms() {
        let filename = NSHomeDirectory().stringByAppendingString("/Documents/platform.bin")
        let data = NSKeyedArchiver.archivedDataWithRootObject(platforms)
        data.writeToFile(filename, atomically: true)
    }
    
}
