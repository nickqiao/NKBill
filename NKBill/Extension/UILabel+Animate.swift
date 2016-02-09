//
//  animate.swift
//  NKBill
//
//  Created by nick on 16/2/9.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class TimerManager {
    var timers = [NSObject : dispatch_source_t]()
    func createTimer(key keyName:NSObject) -> dispatch_source_t {
        let timer:dispatch_source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
        
        timers[keyName] = timer
        
        return timer
    }
    
    func getTimer(key keyName:NSObject) -> dispatch_source_t {
        return timers[keyName]!
    }
    
    func removeTimer(key keyName:NSObject) {
        //remove timer from dictionary
        timers.removeValueForKey(keyName)
    }
}
let timers = TimerManager()

public extension UILabel {
    public func animate(from fromValue:Int, to toValue:Int, duration durationValue:Double = 1.0, useTimeFormat useTimeFromatValue:Bool = false, numberFormatter numberFormatterValue:NSNumberFormatter! = nil, appendText appendTextValue:String = "") {
        
        self.text = String(fromValue.hashValue)
        
        let interval:Double = 10/30
        let nsec:UInt64 = UInt64(interval) * NSEC_PER_SEC
        let dispatchTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(nsec))
        var previousProgress:NSTimeInterval = 0
        var progress:NSTimeInterval = 0
        var lastUpdate:NSTimeInterval = NSDate.timeIntervalSinceReferenceDate();
        var displayValue:Double = Double(fromValue)
        var percent:Double = 0
        var now:NSTimeInterval = 0
        
        //create timer
        timers.createTimer(key: self)
        
        func update() {
            now = NSDate.timeIntervalSinceReferenceDate()
            progress += now - lastUpdate
            lastUpdate = now
            
            if (progress >= durationValue) {
                dispatch_source_cancel(timers.getTimer(key: self))
                timers.removeTimer(key: self)
                progress = durationValue;
            }
            
            let percent = progress / durationValue
            let change:Double = Double(toValue) - Double(fromValue)
            
            
            var easedValue:Double = Easing.easeOutExpo(time: durationValue * percent, start: Double(fromValue), change: change, duration: durationValue)
            
            if (useTimeFromatValue == true) {
                //self.text = Int(easedValue).time + appendTextValue
            } else {
                if (numberFormatterValue != nil) {
                    self.text = numberFormatterValue.stringFromNumber(easedValue)! + appendTextValue
                } else {
                    self.text = "\(Int(easedValue))\(appendTextValue)"
                }
            }
        }
        
        dispatch_source_set_timer(timers.getTimer(key: self), dispatchTime, nsec, 0)
        dispatch_source_set_event_handler(timers.getTimer(key: self), update)
        
        //start timer
        dispatch_resume(timers.getTimer(key: self))
        
        //call update right away
        update()
    }
}