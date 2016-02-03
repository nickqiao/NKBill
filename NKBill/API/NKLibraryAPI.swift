//
//  NKLibraryAPI.swift
//  NKBill
//
//  Created by nick on 16/1/31.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift
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
    
    func getAccountsByDate() -> Results<NKAccount>{
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
    
    func getAccountsFromPlatform(platform: NKPlatform) -> Results<NKAccount> {
        return accountManager.getAccountsByPlatform(platform)
    }
    
    func getSumInvestFromPlatform(platform: NKPlatform) -> Int {
        return accountManager.getSumInvestFromPlatform(platform)
    }
    
    func getOverdueItems() -> Results<NKItem> {
        return accountManager.getOverdueItems()
    }
    
    func getWaitingItems() -> Results<NKItem> {
        return accountManager.getWaitingItems()
    }
    
    func getBeforeWatingItems() -> Results<NKItem> {
        return accountManager.getBeforeWatingItems()
    }
    
    func getTodayWatingItems()-> Results<NKItem> {
        return accountManager.getTodayWatingItems()
    }
    
    func getInAmonthWatingItems() -> Results<NKItem> {
        return accountManager.getInAmonthWatingItems()
    }

    func getAfterAmonthWatingItems() -> Results<NKItem> {
        return accountManager.getOneMonthLaterWatingItems()
    }
    
    func getPassedItems() -> Results<NKItem> {
        return accountManager.getPassedItems()
    }
    
    func getInvestedPlatforms() -> Results<NKPlatform> {
        return accountManager.getInvestedPlatforms()//.sort({ $0.sum > $1.sum })
    }
    
    
    
}
