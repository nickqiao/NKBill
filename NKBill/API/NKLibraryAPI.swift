//
//  NKLibraryAPI.swift
//  NKBill
//
//  Created by nick on 16/1/31.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKLibraryAPI: NSObject {
    private var platformManager:NKPlatformManager
    static let sharedInstance = NKLibraryAPI()
    private override init() {
        
        platformManager = NKPlatformManager()
        super.init()
        
    }
    
    func getPlatforms() -> [NKPlatform] {
        return platformManager.getPlatforms()
    }
    
    func addPlatform(platfrom: NKPlatform,index:Int) {
        platformManager.addPlatform(platfrom,index:index)
    }
    
    func deletePlatform(index:Int) {
        platformManager.deleteplatformAtIndex(index)
    }
    
    func savePlatforms() {
        platformManager.savePlatforms()
    }
    
}
