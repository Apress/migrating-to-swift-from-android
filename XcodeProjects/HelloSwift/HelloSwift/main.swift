//
//  main2.swift
//  HelloSwift
//
//  Created by Sean on 6/27/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import Foundation

println("Hello, World!")

var you = MobileDeveloper()
you.name = "You";
you.writeCode("Swift");


var fileScope: String = ""
class MyClass {
  
  class var MyTypeProperty : String {
    return "class var"
  }
  
  var mProperty : String = "";
  let mConstant : Int = 0;
  
  func myMethod(arg : String) {
    var aVar : String = "";
    let aConstant = 1;
  }
  
  class func MyClassMethod(name : String = "") {
    println(name)
  }
}

MyClass.MyClassMethod(name: "class method");
println(MyClass.MyTypeProperty)

////// functions ////
//func doWork(parm : String) -> String { // simple form
//  return "TODO: " + parm
//}
//println(doWork("swift"))
//
//// External parameter names + default parm value
//func doWork2(name parm : String) -> String {
//// arg = arg.uppercaseString; // error: method parm default to constant
//  return "TODO: " + parm
//}
//println(doWork2(name: "swift")) // name is part of the method signature
//
//func doWork3(#name: String) -> String { // same name for both internal and external
//  // arg = arg.uppercaseString; // error: method parm default to constant
//  return "TODO: " + name
//}
//println(doWork3(name: "Swift"))
//
//// default parm value
//func doWork4(name: String = "Swift") -> String { // also imply externl parm same as internal
//  // arg = arg.uppercaseString; // error: method parm default to constant
//  return "TODO: " + name
//}
//println(doWork4()) // default parm value
//
//// parm is constant unless declaring with var
//func doWork5(var name: String = "Swift") -> String {
//  name = name.uppercaseString;
//  return "TODO: " + name;
//}
//
//// variadic parms
//func sumNumbers(parms : Int...) -> Int {
//  var sum = 0
//  for number in parms {
//    sum += number
//  }
//  return sum
//}
//println(sumNumbers(2,5,8))
//
//// fucn is a type, can be used for parm or return type, etc.
//func separateByAnd(p1: String, p2: String) -> String {
//  return p1 + " and " + p2
//}
//func printTwoString(p1: String, p2: String, format: (String, String)->String) {
//  println(format(p1, p2))
//}
//printTwoString("Apple", "Orange", separateByAnd)
//
//// closure is unnamed func
//printTwoString("Apple", "Orange", {(p1: String, p2: String) -> String in
//    return p1 + " and " + p2
//  })
//printTwoString("Apple", "Orange", {p1,p2 in // p1, p2 and return type is infered.
//  return p1 + " and " + p2
//  })
//printTwoString("Apple", "Orange", { // Inference and shorthanded parm names
//  return $0 + " and " + $1
//  })

class SimpleClass {
  var mProperty : Int = 0
  var mConstant : String = "MyKey"
  func myMethod(name: String) { println(name)}
}

class SwiftClass {
  
  var width = 10, height = 10 // stored properties

  // computed properties, can have set as well
  var size : Int {
  get {
    return width * height
  }
  }
  
  var size2 : Int { // readonly, shorthaned
  return width * height
  }
  
  // property observer
  var depth : Int = 10 {
  willSet {
    println("depth (\(depth)) will be set to \(newValue)")
  }
  didSet {
    println("depth (\(depth)) was be set from \(oldValue)")
  }
  }
  
  // Swift Type property
//  class var MyTypeProperty = 10 // error: class var not yet supported
  class var MyComputedTypeProperty : String {
    return "computed Type property is supported"
  }
  
///////// methods copied from Listing 2-17 //////////
  func doWork(parm : String) -> String { // simple form just like functions
    return "TODO: " + parm
  }
  
  // default parm value
  func doWork2(name: String = "Swift") -> String { // also imply externl parm same as internal
    // arg = arg.uppercaseString; // error: method parm default to constant
    return "TODO: " + name
  }
  
  // fucn is a type, can be used for parm or return type, etc.
  func separateByAnd(p1: String, p2: String) -> String {
    return p1 + " and " + p2
  }

  func printTwoString(p1: String, p2: String, format: (String, String)->String) {
    println(format(p1, p2))
  }
  
  // Type methods, aka Java class static method
  class func DoWork(parm : String) -> String {
    return "TODO: (Just like Java class static method)" + parm
  }

}

var c = SwiftClass()
println(c.doWork("Swift"))
println(c.doWork2()) // default parm value
println(c.doWork2(name: "Swift")) // default parm value implies external name

// closure is unnamed func
c.printTwoString("Horse", p2: "Carrot", format: c.separateByAnd)
c.printTwoString("Apple", p2: "Orange", format: { // Inference and shorthanded parm names
  return $0 + " and " + $1
  })

SwiftClass.DoWork("Swift Type method")



//////////////////////////////

func incrementBy(amount: Int, numberOfTimes: Int) {
  println("func")
}




