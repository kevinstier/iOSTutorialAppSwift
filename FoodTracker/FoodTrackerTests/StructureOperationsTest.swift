//
//  StructureOperationsTest.swift
//  FoodTrackerTests
//
//  Created by Tizin MacBook Pro on 16/01/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import XCTest

private let maxRandomNumber = 100000

class StructureOperationsTest: PerformanceTest {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Arrays
    
    func testArrayAdd() {
        self.performTimeTest(ArrayHelper.generateArray, operationBlock: {(array: [String]) -> TimeInterval in
            var arr = array
            
            let start = CACurrentMediaTime()
            arr.append(self.randomString())
            let finish = CACurrentMediaTime()
            return finish - start
    }, structureName: "Array", operationName: "Toevoegen")
    }
    
    func testArrayUpdate() {
        self.performTimeTest(ArrayHelper.generateArray,
                             operationBlock: {(array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                                var arr = array
                                let start = CACurrentMediaTime()
                                arr[randomIndex!] = self.randomString()
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: ArrayHelper.randomArrayIndex,
                             randomElementBlock: ArrayHelper.randomArrayElement,
                             structureName: "Array", operationName: "Updaten")
    }
    
    func testArrayByIndexRead() {
        self.performTimeTest(ArrayHelper.generateArray,
                             operationBlock: {(array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                                let start = CACurrentMediaTime()
                                let constant = array[randomIndex!]
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: ArrayHelper.randomArrayIndex,
                             randomElementBlock: ArrayHelper.randomArrayElement,
                             structureName: "Array", operationName: "Lezen")
    }
    
    func testArrayByIndexDelete() {
        self.performTimeTest(ArrayHelper.generateArray,
                             operationBlock: {(array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                                var arr = array
                                let start = CACurrentMediaTime()
                                arr.remove(at: randomIndex!)
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: ArrayHelper.randomArrayIndex,
                             randomElementBlock: ArrayHelper.randomArrayElement,
                             structureName: "Array", operationName: "Verwijderen")
        
    }
    
    func testArrayContains() {
        self.performTimeTest(ArrayHelper.generateArray,
                             operationBlock: {(array: [String], randomIndex: Int?, randomElement: String?) -> TimeInterval in
                                let start = CACurrentMediaTime()
                                let constant = array.contains(randomElement!)
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: ArrayHelper.randomArrayIndex,
                             randomElementBlock: ArrayHelper.randomArrayElement,
                             structureName: "Array", operationName: "Bevat")
        
    }
    
    //MARK: Sets
    
    func testSetAdd() {
        self.performTimeTest(SetHelper.generateSet,
                             operationBlock: { (set: Set<String>) -> TimeInterval in
                                var s = set
                                let start = CACurrentMediaTime()
                                s.insert(tempString + String(Random.rndInt(0, to: maxRandomNumber)))
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             structureName: "Set", operationName: "Toevoegen")
    }
    
    func testSetDelete() {
        self.performTimeTest(SetHelper.generateSet,
                             operationBlock: {(set: Set<String>, randomIndex: Int?, randomElement: String?) -> TimeInterval in
                                var s = set
                                let start = CACurrentMediaTime()
                                s.remove(randomElement!)
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: SetHelper.randomSetIndex,
                             randomElementBlock: SetHelper.randomSetElement,
                             structureName: "Set", operationName: "Verwijderen")
    }
    
    func testSetCheckContain() {
        self.performTimeTest(SetHelper.generateSet,
                             operationBlock: {(set: Set<String>, randomIndex: Int?, randomElement: String?) -> TimeInterval in
                                let start = CACurrentMediaTime()
                                let constant = set.contains(randomElement!)
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: SetHelper.randomSetIndex,
                             randomElementBlock: SetHelper.randomSetElement,
                             structureName: "Set", operationName: "Bevat")
    }
    
    //MARK: Dictionaries
    
    func testDictionaryAdd() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
                             operationBlock: { (dict: [String: String]) -> TimeInterval in
                                let uniqueKey = tempString + String(dict.count)
                                var d = dict
                                let start = CACurrentMediaTime()
                                d[uniqueKey] = self.randomString()
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             structureName: "Dictionary", operationName: "Toevoegen")
    }
    
    func testDictionaryUpdate() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
                             operationBlock: { (dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                                var d = dictionary
                                let start = CACurrentMediaTime()
                                d[randomIndex!] = self.randomString()
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
                             randomElementBlock: DictionaryHelper.randomDictionaryElement,
                             structureName: "Dictionary", operationName: "Updaten")
    }
    
    func testDictionaryReadByKey() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
                             operationBlock: {(dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                                let start = CACurrentMediaTime()
                                let constant = dictionary[randomIndex!]
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
                             randomElementBlock: DictionaryHelper.randomDictionaryElement,
                             structureName: "Dictionary", operationName: "Lezen")
    }
    
    func testDictionaryDeleteByKey() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
                             operationBlock: {(dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                                var d = dictionary
                                let start = CACurrentMediaTime()
                                d.removeValue(forKey: randomIndex!)
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
                             randomElementBlock: DictionaryHelper.randomDictionaryElement,
                             structureName: "Dictionary", operationName: "Verwijderen")
    }
    
    func testDictionaryCheckContain() {
        self.performTimeTest(DictionaryHelper.generateDictionary,
                             operationBlock: {(dictionary: [String: String], randomIndex: String?, randomElement: String?) -> TimeInterval in
                                let start = CACurrentMediaTime()
                                dictionary.values.contains(randomElement!)
                                let finish = CACurrentMediaTime()
                                return finish - start
        },
                             randomIndexBlock: DictionaryHelper.randomDictionaryIndex,
                             randomElementBlock: DictionaryHelper.randomDictionaryElement,
                             structureName: "Dictionary", operationName: "Bevat")
    }
    
    private func randomString() -> String {
        return tempString + String(Random.rndInt(0, to: maxRandomNumber))
    }
    
}
