//
//  NKAlgorithm.swift
//  NKBill
//
//  Created by nick on 16/2/1.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation


func createItems(invest:Int,rate: Double,length:Int,repayType:RepayType,date: NSDate) -> [NKItem]{
    
    switch repayType {
    case .InterestByMonth :
        return fun1(invest, rate: rate, month: length, date: date)
    case .AverageCapital :
        return fun2(invest, rate: rate, month: length, date: date)
    case .RepayAllAtLast:
        return fun3(invest, rate: rate, month: length, date: date)
    default:
        return [NKItem]()
    }
    
}

/// 按月计息
func fun1(invest:Int,rate: Double,month:Int,date:NSDate) -> [NKItem] {
    
    var items:[NKItem] = []
    for index in 1...Int(month) {
        let item = NKItem()
        
        item.repayDate = date.NK_dateByAddingMonths(index)
        
        item.interest = Double(invest) * rate / 12
        
        if index == Int(month) {
            item.principal = Double(invest)
        }else {
            item.principal = 0
        }
        item.sum = item.interest + item.principal
        items.append(item)
    }
    return items
}

/// 等额本息
func fun2(invest:Int,rate: Double,month:Int,date:NSDate) -> [NKItem] {
    
    var items:[NKItem] = []
    for index in 1...month {
        let item = NKItem()
        
        let monthRate = rate / 12.0
        let AB = Double(invest) * monthRate * pow(1.0 + monthRate , Double(month)) / (pow(1.0 + monthRate, Double(month)) - 1.0);
        // 每月本金
        let A = Double(invest) * monthRate * pow(1.0 + monthRate, Double(index - 1))/(pow(1.0 + monthRate, Double(month)) - 1.0);
        // 每月利息
        let B = AB - A;
        
        item.principal = A
        item.interest = B
        item.sum = AB
       
        item.repayDate = date.NK_dateByAddingMonths(index)
        items.append(item)
    }
    return items
}

/// 到期还本息
func fun3(invest:Int,rate: Double,month:Int,date:NSDate) -> [NKItem]{
    let item = NKItem()
    item.principal = Double(invest)
    item.interest = Double(invest) * rate * Double(month) / 12.0
    item.sum = item.interest + item.principal
    
    item.repayDate = date.NK_dateByAddingMonths(month)
    return [item]
}

