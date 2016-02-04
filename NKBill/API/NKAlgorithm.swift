//
//  NKAlgorithm.swift
//  NKBill
//
//  Created by nick on 16/2/1.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

func createItems(account:NKAccount) -> [NKItem]{
    
    switch account.repayType {
    case RepayType.InterestByMonth.rawValue :
        return fun1(account)
    case RepayType.AverageCapital.rawValue :
        return fun2(account)
    case RepayType.RepayAllAtLast.rawValue:
        return fun3(account)
    default:
        return [NKItem]()
    }
    
}

/// 按月计息
func fun1(account:NKAccount) -> [NKItem] {
    
    var items:[NKItem] = []
    for index in 1...Int(account.timeSpan) {
        let item = NKItem()
        item.order = index
        item.account = account
        item.repayDate = account.created.NK_dateByAddingMonths(index)
        
        item.interest = Double(account.invest) * account.rate / 12
        
        if index == Int(account.timeSpan) {
            item.principal = Double(account.invest)
        }else {
            item.principal = 0
        }
        item.sum = item.interest + item.principal
        
        items.append(item)
    }
    return items
}

/// 等额本息
func fun2(account:NKAccount) -> [NKItem] {
    
    var items:[NKItem] = []
    for index in 1...account.timeSpan {
        let item = NKItem()
        item.order = index
        item.account = account
        let monthRate = account.rate / 12.0
        let AB = Double(account.invest) * monthRate * pow(1.0 + monthRate , Double(account.timeSpan)) / (pow(1.0 + monthRate, Double(account.timeSpan)) - 1.0);
        // 每月本金
        let A = Double(account.invest) * monthRate * pow(1.0 + monthRate, Double(index - 1))/(pow(1.0 + monthRate, Double(account.timeSpan)) - 1.0);
        // 每月利息
        let B = AB - A;
        
        item.principal = A
        item.interest = B
        item.sum = AB
       
        item.repayDate = account.created.NK_dateByAddingMonths(index)
        items.append(item)
    }
    return items
}

/// 到期还本息
func fun3(account:NKAccount) -> [NKItem]{
    let item = NKItem()
    item.order = 1
    item.account = account
    item.principal = Double(account.invest)
    item.interest = Double(account.invest) * (account.rate) * Double(account.timeSpan) / 12.0
    item.sum = item.interest + item.principal
    
    item.repayDate = account.created.NK_dateByAddingMonths(account.timeSpan)
    return [item]
}

