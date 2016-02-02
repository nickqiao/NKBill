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
    
    
    func deleteAccounts(accounts:[NKAccount]) {
        accountManager.deleteAccounts(accounts)
    }
    
    func saveAccount(account: NKAccount) {
        accountManager.saveAccount(account)
    }
    
    func getAccountsByDate() -> [NKAccount]{
        return accountManager.getAccountsByDate()
    }
    
    func getSumInvest() -> Int {
        return accountManager.getSumInvest()
    }

    func getPassedInterest() -> Double {
        return accountManager.getPassedInterest()
    }
    
    func getWatingInterest() -> Double {
        return accountManager.getWatingInterest()
    }
    
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int {
        return accountManager.getSumInvestFromPlatform(platform)
    }
    
    func getOverdueItems() -> [NKItem] {
        return accountManager.getOverdueItems()
    }
    
    func getWaitingItems() -> [NKItem] {
        return accountManager.getWaitingItems()
    }
    
    func getPassedItems() -> [NKItem] {
        return accountManager.getPassedItems()
    }
    
    func getInvestedPlatforms() -> [NKPlatform] {
        return accountManager.getInvestedPlatforms().sort({ $0.sum > $1.sum })
    }
    
}
