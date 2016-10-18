//
//  RentalROITests.swift
//  RentalROITests
//
//  Created by Sean on 8/7/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit
import XCTest

class RentalROITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
  
  
  
  func testSave() {
    var isOk = self.saveUserdefault("data", forKey: "key1")
    XCTAssert(isOk, "save failed")
    
    var data = userDefaults.objectForKey("key1") as String?
    XCTAssert("data" == data!, "data not retrieved")
  }
  
  func testSaveDictionary() {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var jo : [NSObject : AnyObject] = [
      "a" : 1.0,
      "b" : 2.0
    ]
    
    let akey = "aKey"
    userDefaults.setObject(jo, forKey: akey)
    var isOk = userDefaults.synchronize()
    
    var data: AnyObject? = userDefaults.objectForKey(akey)
    
    
    var dict = data! as NSDictionary
    
    XCTAssert(jo.count == data!.count, "No good")
  
  }
  
  
  
  
  let userDefaults = NSUserDefaults.standardUserDefaults()
  func saveUserdefault(data: AnyObject, forKey: String) -> Bool {
    userDefaults.setObject(data, forKey: forKey)
    return userDefaults.synchronize()
  }
  
  func retrieveUserdefault(key: String) -> AnyObject? {
    var obj: AnyObject? = userDefaults.objectForKey(key)
    return obj
  }
  
  func deleteUserDefault(key: String) {
    self.userDefaults.removeObjectForKey(key)
  }
  
  
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
