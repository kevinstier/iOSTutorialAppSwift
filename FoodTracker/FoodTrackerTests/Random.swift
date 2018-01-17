//
//  Random.swift
//  FoodTrackerTests
//
//  Created by Tizin MacBook Pro on 16/01/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Random {
    
    class func rndInt(_ from: Int, to: Int) -> Int {
        return Int(arc4random_uniform(UInt32((to - from + 1)))) + from
    }
    
    class func rndDouble(_ from: Double, to: Double) -> Double {
        return drand48() * (to - from) + from;
    }
    
    class func rndBool() -> Bool {
        return Random.rndInt(0, to: 1) == 1;
    }
    
    class func willHappen(probability: Double) -> Bool {
        return Random.rndDouble(0, to: 1) <= probability
    }
    
    class func oneof<T>(array: Array<T>) -> T {
        if (array.count == 1) {
            return array[0]
        }
        let index = Random.rndInt(0, to: array.count - 1)
        return array[index]
    }
}
