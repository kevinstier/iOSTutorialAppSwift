//
//  PerformanceTest.swift
//  FoodTrackerTests
//
//  Created by Tizin MacBook Pro on 16/01/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import XCTest
import QuartzCore

let tempString = "temp"
let iterations = 10
let elementsInStructure = 500

class PerformanceTest : XCTestCase {
    
//    func performTimeTest(_ prepareBlock: (Int) -> [String], operationBlock: ([String]) -> TimeInterval, structureName: String, operationName: String) {
//        var attemptsWithSumTime = [TimeInterval](repeating: 0, count: elementsInStructure)
//        
//        for _ in 0..<iterations {
//            for elementCount in 0..<elementsInStructure {
//                let structure = prepareBlock(elementCount)
//                let time = operationBlock(structure)
//                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
//            }
//        }
//        
//        self.writeToCSV(structureName: structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
//    }
    
    func performTimeTest<S>(_ prepareBlock: (Int) -> S, operationBlock: (S) -> TimeInterval, structureName: String, operationName: String) {
        var attemptsWithSumTime = [TimeInterval](repeating: 0, count: elementsInStructure)
        
        for _ in 0..<iterations {
            for elementCount in 0..<elementsInStructure {
                let structure = prepareBlock(elementCount)
                let time = operationBlock(structure)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName: structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    func performTimeTest<S, E, I>(_ prepareBlock: (Int) -> S, operationBlock: (S, I?, E?) -> TimeInterval, randomIndexBlock: (S) -> I, randomElementBlock: (S, I) -> E, structureName: String, operationName: String) {
        var attemptsWithSumTime = [TimeInterval](repeating: 0, count: elementsInStructure)
        
        for _ in 0..<iterations {
            for elementCount in 0..<elementsInStructure {
                if (elementCount == 0) {
                    continue
                }
                let structure = prepareBlock(elementCount)
                var randomIndex: I?
                var randomElement: E?
                if (elementCount != 0) {
                    randomIndex = randomIndexBlock(structure)
                    randomElement = randomElementBlock(structure, randomIndex!)
                }
                
                let time = operationBlock(structure, randomIndex, randomElement)
                attemptsWithSumTime[elementCount] = attemptsWithSumTime[elementCount] + time
            }
        }
        
        self.writeToCSV(structureName: structureName, operationName: operationName, attemptsWithSumTime: attemptsWithSumTime)
    }
    
    private func writeToCSV(structureName: String, operationName: String, attemptsWithSumTime: [TimeInterval]) {
        //write to csv
        let path = NSHomeDirectory() + "/" + structureName + "-" + operationName + ".csv"
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print("File remove error voor " + structureName + "-" + operationName)
        }
        
        
        let output = OutputStream.toMemory()
        let delimiter: unichar = 44 // comma unichar
        let writer = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: delimiter)
        writer?.writeField("")
        writer?.writeField("Swift")
        writer?.finishLine()
        for elementCount in 0..<elementsInStructure {
            let average = attemptsWithSumTime[elementCount] / TimeInterval(iterations)
            writer?.writeField(elementCount)
            writer?.writeField(average)
            writer?.finishLine()
        }
        writer?.closeStream()
        
        let buffer: NSData = output.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as! NSData
        let csv = NSString(data: buffer as Data, encoding: String.Encoding.utf8.rawValue)
        
        do {
            try csv?.write(toFile: path, atomically: false, encoding: String.Encoding.utf8.rawValue)
        } catch {
            print("CSV write error voor " + structureName + "-" + operationName)
        }
        //csv?.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
    }
}
