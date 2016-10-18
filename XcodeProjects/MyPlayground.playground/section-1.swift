// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
println(str)

////// Swift Optional Int type
var intStr = "123"
var myOptionalInt : Int? = intStr.toInt() // Optional Int
if myOptionalInt != nil { // valid for Optional types
  var myInt = myOptionalInt! // Unwrap Int? to Int
  println("unWrappedInt: \(myInt)")
} else {
  var myInt = myOptionalInt! // runtime error.
}

// optional binding used in if and while local scope.
if var myInt = intStr.toInt() { // auto unwrap to Int
  println("unwrapped and local scope: \(myInt)")
}

var iuo: Int
iuo = 0
println("implicitly unwrapped option: \(iuo)")


println()

let possibleString: String? = "An optional string."
println(possibleString!) // requires an exclamation mark to access its value
println(possibleString) // requires an exclamation mark to access its value

let assumedString: String! = "An implicitly unwrapped optional string."
println(assumedString)  // no exclamation mark is needed to access its value
println(assumedString!)  // no exclamation mark is needed to access its value


// collections
var colors = ["red", "green", "blue"]
var colorDictionary = ["r" : "red", "g" : "green", "b" : "blue"]
colors.append("alpha") // or: colors += "alpha"
colorDictionary["a"] = colors[3]
colors.insert("pink", atIndex: 2)
colors.removeAtIndex(2)
println(colors.isEmpty ? "empty" : "\(colors.count)")

var emptyArray = Array<String>() // or [String]()
var emptyDict = Dictionary<Int, String>() // [Int: String]()


// if, just like Java
if colors.isEmpty {
  println("true");
} else {
  println("false");
}

// Tuples
var xyz  = (x: 0, y: 0, z: 0)
println("xyz \(xyz) x is: \(xyz.x)\ty is: \(xyz.y)\tz is: \(xyz.z)")

// or decompose tuples
var xy : (Int, Int) = (1, 1) // or simply var xy = (1, 1)
var (a, b) = xy
println("xy \(xy) x is: \(a)\ty is: \(b)")

func httpResponse() -> (rc: Int, status: String) {
  return (200, "OK")
}

var resp = httpResponse()
println("resp is: \(resp.rc)\t\(resp.status)")

// for-loop
for (var idx = 0; idx < 10; idx++) { // parenthensis is optional
  println("for-loop: \(idx)")
}

// for-in
println("=== for-in ===")
for item in 1...5 { // or for idx in 1...5
  println("for-in: \(item)")
}

for c in "HelloSwift" {   print(c) }
println()

// for-in dictionary
for (key, value) in colorDictionary {
  println("for-in dictionary:\(key) - \(value)")
}

// while-loop
var idx = 0
while idx < colors.count {
  println("while-loop:  \(colors[idx])")
  idx++
}

idx = 0
do {
  println("do-while:  \(colors[idx])") // make sure colors not empty.
  idx++
} while idx < colors.count

// improved switch




/////
var condition = "red"switch condition {case "red", "green", "blue": // combined cases, separate by comma  println("\(condition) is a prime color")  //  break                   // always break implicitlycase "RED", "GREEN", "BLUE": // no follow thru.  println("\(condition) is a prime color in uppercase")default: // not optional anymore  println("\(condition) is not prime color")}

/////


var range = 9 // by range
switch range {
  case 0:
  println("zero")
  case (0...9) : // range
  println("one-digit number")
  case 10...99:
  println("two-digit number")
  case 10...999: // first hit first
  println("three-digit number")
  default:
  println("four or more digits")
  }
  
var coord = (0, 1) // with tuples
switch coord {
  case (0...Int.max, 0...Int.max):
    println("1st quad")
  case (Int.min...0, 0...Int.max):
    println("2nd quad")
  case (Int.min...0, Int.min...0):
    println("3rd quad")
  case (0...Int.max, Int.min...0):
    println("4th quad")
  default:
  println("on axis")
  }
  
var rect = (10, 11)
switch rect {
  case let (w, h) where w == h:
      println("\((w, h)) is a square")
  default:
      println("rectangle but not square")
  }
  
  //public String doWork(String arg) {
  //  return "TODO: " + arg;
  //}
  
func doWork(parm : String) -> String {
        return "TODO: " + parm ;
}
println(doWork("swift"))
  //println(doWork() // error
  
  // external parameter names
func doWork2(name parm : String = "swift") -> String {
    //  arg = arg.uppercaseString; // error: method parm default to constant
    return "TODO: " + parm;
}
println(doWork2(name: "swift")) // name is part of the method signature
println(doWork2()) // default parm

// default constant parm
func doWork3(var name parm : String = "swift") -> String {
    parm = parm.uppercaseString; // arg is a variable
    return "TODO: " + parm;
}

func sumNumbers(parms : Int...) -> Int {
  var sum = 0
  for number in parms {
  sum += number
  }
  return sum
}
println(sumNumbers(2,5,8))


func separateByAnd(p1: String, p2: String) -> String {
    return p1 + " and " + p2
}

func printTwoString(p1: String, p2: String, format: (String, String)->String) {
    println(format(p1, p2))
}

printTwoString("Apple", "Orange", separateByAnd)

// closure is unnamed func
printTwoString("Apple", "Orange",
  {(p1: String, p2: String) -> String in
  return p1 + " and " + p2
  })

printTwoString("Apple", "Orange",
  {p1,p2 in // p1, p2 and return type is infered.
  return p1 + " and " + p2
  })

printTwoString("Apple", "Orange",
    { // shortest form: , inference and shorthanded parm names
    return $0 + " and " + $1
    })
  
  
// enum
enum DayOfWeek { // raw value is optional
    case SUNDAY, MONDAY, TUESDAY, WEDNESDAY,
    THURSDAY, FRIDAY, SATURDAY
}

var aDay = DayOfWeek.SUNDAY
switch aDay {
case DayOfWeek.SATURDAY, DayOfWeek.SUNDAY:
  println("\(aDay) is weekend")
default:
  println("\(aDay) is weekday")
}

enum DayOfWeek2 : String { // assign raw value
  case SUNDAY = "Sun", MONDAY = "Mon", TUESDAY = "Tue",
  WEDNESDAY = "Wed", THURSDAY = "Thu", FRIDAY = "Fri", SATURDAY = "Sat"
}

var aDay2 = DayOfWeek2.SUNDAY
switch aDay2 {
  case DayOfWeek2.SATURDAY, DayOfWeek2.SUNDAY:
  println("\(aDay2.rawValue) is weekend")
  default:
  println("\(aDay2.rawValue) is weekday")
}

  // associates
enum Color {
  case RGB(Int, Int, Int)
  case HSB(Float, Float, Float)
}

var aColor = Color.RGB(255, 0, 0)
switch aColor {
  case var Color.RGB(r, g, b):
    println("R: \(r) G: \(g) B: \(b) ")
  default:
  println("")
  }
  
class MyClass {  var width = 10, height = 10 // stored properties    // computed properties, can have set as well  var size : Int {  get {  return width * height  }  }    var size2 : Int { // readonly, shorthaned  return width * height  }    // property observer  var depth : Int = 10 {  willSet {  println("depth (\(depth)) will be set to \(newValue)")  }  didSet {  println("depth (\(depth)) was be set from \(oldValue)")  }  }    // Swift Type property,  class var MyComputedTypeProperty : String {return "Only computed Type property is supported"  }
  
  struct MyStatic {
  static let MyConst = "final static in Java"
  static var MyVar: String = ""
  }
  
  ///////// methods copied from Listing 2-17 //////////  func doWork(parm : String) -> String { // just like func    return "TODO: " + parm  }    // default parm value, always imply externl parm name  func doWork2(name: String = "Default to Swift") -> String {    return "TODO: " + name  }    // fucn is a type, can be used for parm or return type, etc.  func separateByAnd(p1: String, p2: String) -> String {    return p1 + " and " + p2  }    func printTwoString(p1:String, p2:String, format:(String, String)->String) {    println(format(p1, p2))  }    // Type methods, aka Java class static method  class func DoWork(parm : String) -> String {    return "TODO: (Just like Java class static method)" + parm  }
}

println(MyClass.MyStatic.MyConst)
MyClass.MyStatic.MyVar = "class var in Java"
println(MyClass.MyStatic.MyVar)
  
var c = MyClass()
c.doWork("Swift")
c.doWork2(name: "Swift") // external name enforced
c.doWork2() // default parm value
MyClass.DoWork("Swift Type method")
    // closure is unnamed funcc.printTwoString("Horse", p2: "Carrot", format: c.separateByAnd)
    // Inference and shorthanded parm names apply to method, too.c.printTwoString("Apple", p2: "Orange", format: {    return $0 + " and " + $1    })
