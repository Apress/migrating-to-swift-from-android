//
//  RestClientTests.swift
//  RestClientTests
//
//  Created by Sean on 7/28/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit
import XCTest

class Connector {
  
  struct MyStatic {
    static let SERVER = "http://10.10.1.81/"
    static let CATEGORIES = "categories"
    static let CATEGORY = "category"
    static let PRODUCTS = "products"
    static let PRODUCT = "product"
    
    static var returnData: NSData?
    static var resp: NSURLResponse?
    static var error: NSError?
  }
  
  class func GetProducts() -> [AnyObject]? { /*Array<Dictionary<String, String>>?*/
    Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.PRODUCTS)
    
    var returnData = Connector.MyStatic.returnData
    if let tmp = returnData {
      var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
      return json
    } else {
      return [];
    }
  }
  
  class func GetProduct() -> [AnyObject]? { /*Array<Dictionary<String, String>>?*/
    Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.PRODUCT)
    
    var returnData = Connector.MyStatic.returnData
    if let tmp = returnData {
      var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
      return json
    } else {
      return [];
    }
  }
  
  class func GetProduct(#id: Int) -> NSDictionary? {
    Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.PRODUCT + "/\(id)")
    
    var returnData = Connector.MyStatic.returnData
    if let tmp = returnData {
      var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary?
      return json
    } else {
      return nil;
    }
  }
  
  class func GetCategories() -> [AnyObject]? { /*Array<Dictionary<String, String>>?*/
    Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.CATEGORIES)
    
    var returnData = Connector.MyStatic.returnData
    if let tmp = returnData {
      var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
      return json
    } else {
      return [];
    }
  }
  
  class func GetCategory() -> [AnyObject]? { /*Array<Dictionary<String, String>>?*/
    Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.CATEGORY)
    
    var returnData = Connector.MyStatic.returnData
    if let tmp = returnData {
      var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
      return json
    } else {
      return [];
    }
  }
  
  class func GetCategory(#id: Int) -> NSDictionary? {
    Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.CATEGORY + "/\(id)")
    
    var returnData = Connector.MyStatic.returnData
    if let tmp = returnData {
      var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary?
      return json
    } else {
      return nil;
    }
  }
  
  private class func doGet(url: String) {
    var urlRequest = NSMutableURLRequest(URL: NSURL(string: url))
    urlRequest.HTTPMethod = "GET"
    urlRequest.setValue("text/html", forHTTPHeaderField: "accept")
    
    Connector.MyStatic.returnData = nil
    //    NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(),
    //      completionHandler: {(resp: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
    //        println(resp.MIMEType)
    //        println(resp.textEncodingName)
    //        Connector.MyStatic.returnData = data
    //    })
    
    Connector.MyStatic.returnData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: &MyStatic.resp, error: &MyStatic.error)
    
  }
}

class RestClientTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testGetPRODUCTS() {
    //    product:{
    //      id: 0,
    //      name: "",
    //      featureImageURLs: [""],
    //      categoryTags: [{tag}],
    //      productNumberSlot: 0,
    //      unitPrice: 0.0,
    //      unitType: "",
    //      unitSize: "",
    //      unitSizeType: "",
    //      shortDescription: "",
    //      longDescription: "",
    //      informationDocs: [{informationDoc}],//e.g. ingredients, instructions, legal
    //      faq: [{faq}]
    //    }
    
    let KEYS = ["id",
      "name",
      "featureImageURLs",
      "categoryTags",
      "productNumberSlot",
      "unitPrice",
      "unitType",
      "unitSize",
      "unitSizeType",
      "shortDescription",
      "longDescription",
      "informationDocs",
      "faq"
    ]
    
    var returnData = Connector.GetProducts()
    
    if let products = returnData {
      
      for product in products {
        for key in product.allKeys {
          // verify key
          var elements = KEYS.filter({
            return $0 == (key as String)
          })
          
          println("element count = \(elements.count): \(key.description): \(product[key as String])")
          
          // verify data
          XCTAssert(elements.count == 1, "element count = \(elements.count): \(key.description)")
        }
      }
      
      XCTAssert(true, products.description)
    } else {
      XCTFail("failed: \(Connector.MyStatic.error!.description)")
    }
  }
  
  func testGetPRODUCT() {
    
    var returnData = Connector.GetProduct()
    if let products = returnData {
      
      for product in products {
        if let n = product as? Int {
          XCTAssert(n > 0, "id cannot be zero")
        } else {
          XCTAssert(false, "id has to be Int: \(product)")
        }
      }
      
    } else {
      XCTFail("failed: \(Connector.MyStatic.error!.description)")
    }
  }
  
  func testGetCATEGORIES() {
//    category:{
//      id: 0,
//      selfTag: {tag},
//      parentTags: [{tag}],//Other categories that this one is child of
//      caroselImageURLs: [""]
//    }
    let KEYS = ["id", "selfTag", "parentTags", "carouselImageURLs"]
    
    var returnData = Connector.GetCategories()
    
    if let categories = returnData {
      
      for category in categories {
        for key in category.allKeys {
          var elements = KEYS.filter({
            return $0 == (key as String)
          })

          var isGoodCategory = elements.count == 1
          XCTAssert(isGoodCategory, "should be only one => \(elements.count): \(key.description)")
        
          if isGoodCategory {
            // test the category
            var id = category["id"] as Int
            var category2: NSDictionary? = Connector.GetCategory(id: id)
            // category2 should not be empty
            
            if let tmp = category2 {
              // not empty
//              println(tmp)
            } else {
              XCTAssert(false, "category/\(id) is empty")
            }
          }
          
        }
      }
      
      XCTAssert(true, categories.description)
    } else {
      XCTFail("failed: \(Connector.MyStatic.error!.description)")
    }
  }
  
  func testGetCATEGORY() {
    var returnData = Connector.GetCategory()
    
    if let ids = returnData {
      for id in ids {
        if let tmp = id as? Int {
          XCTAssert(tmp > 0, "id cannot be zero: \(tmp)")
        } else {
          XCTAssert(false, "id has to be Int: \(id)")
        }
      }
    } else {
      XCTFail("failed: \(Connector.MyStatic.error!.description)")
    }
  }
  
  
//  func testPerformanceExample() {
//    // This is an example of a performance test case.
//    self.measureBlock() {
//      // Put the code you want to measure the time of here.
//      Connector.doGet(Connector.MyStatic.SERVER + Connector.MyStatic.PRODUCTS)
//      
//      var returnData = Connector.MyStatic.returnData
//      
//      if let tmp = returnData {
//        var json = NSJSONSerialization.JSONObjectWithData(tmp, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
//        XCTAssert(true, json.description)
//      } else {
//        XCTFail("failed: \(Connector.MyStatic.SERVER + Connector.MyStatic.PRODUCTS)")
//      }
//    }
//  }
}

