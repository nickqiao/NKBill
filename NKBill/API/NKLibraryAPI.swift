//
//  NKLibraryAPI.swift
//  NKBill
//
//  Created by nick on 16/1/31.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKLibraryAPI: NSObject {
    
    private var platformManager: NKPlatformManager
    private var accountManager: NKAccountManager
    static let sharedInstance = NKLibraryAPI()
    
    private override init() {
        platformManager = NKPlatformManager()
        accountManager = NKAccountManager()
        super.init()
    }

}

extension NKLibraryAPI {
    func getPlatforms() -> [NKPlatform] {
        return platformManager.getPlatforms()
    }
    
    func addPlatform(platfrom: NKPlatform) {
        platformManager.addPlatform(platfrom)
    }
    
    func deletePlatform(platform:NKPlatform) {
        platformManager.deleteplatform(platform)
    }
    
    func savePlatforms() {
        platformManager.savePlatforms()
    }
}

extension NKLibraryAPI {
    
    func getAccounts() -> [NKAccount]{
        return accountManager.getAccounts()
    }
    
    func deleteAccounts(accounts:[NKAccount]) {
        accountManager.deleteAccounts(accounts)
    }
    
    func saveAccount(account: NKAccount) {
        accountManager.saveAccount(account)
    }
    
    func getAccountsByPlatform(platform: NKPlatform) -> [NKAccount]{
        return accountManager.getAccountsByPlatform(platform)
    }
    
    func getAccountsByDate() -> [NKAccount]{
        return accountManager.getAccountsByDate()
    }
    
    func getSumInvest() -> Int {
        return accountManager.sumInvest()
    }

    
}
