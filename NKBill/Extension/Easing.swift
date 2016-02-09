//
//  Easing.swift
//  NKBill
//
//  Created by nick on 16/2/9.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

struct Easing {
    // Linear
    static func noEasing(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        return c * t / d + b;
    }
    
    // Quintic
    static func easeInQuint(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        let newT:Double = t/d
        
        return c*(newT)*newT*newT*newT*newT + b;
    }
    
    // Sine
    static func easeInSine(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        return -c * cos(t/d * M_PI) + c + b;
    }
    
    static func easeOutSine(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        return c * sin(t/d * (M_PI/2)) + b;
    }
    
    static func easeInOutSine(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        return -c/2 * (cos(M_PI*t/d) - 1) + b;
    }
    
    // Exponential
    static func easeOutExpo(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        return (t==d) ? b+c : c * (-pow(2, -10 * t/d) + 1) + b;
    }
    
    // Quadratic
    static func easeOutQuad(time t:Double, start b:Double, change c:Double, duration d:Double) -> Double {
        let newT:Double = t/d
        return -c * (newT) * (newT-2) + b;
    }
}