//
//  ViewController.swift
//  SaveData
//
//  Created by Sean on 7/26/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  let STORAGE_KEY = "key"
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mTextField.text = self.retrieveUserInput()
    
//    var person = Person.load(STORAGE_KEY)
//    if person {
//      self.mTextField.text = person?.name
//    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func doDelete(sender: AnyObject) {
    // TODO
    self.deleteUserInput();
    self.mTextField.text = nil
  }

  @IBOutlet weak var mTextField: UITextField!
  // called when 'return' key pressed. return NO to ignore.
  func textFieldShouldReturn(textField: UITextField!) -> Bool {
    textField.resignFirstResponder()
    
    self.saveUserInput(self.mTextField.text)
    
//    var person = Person(name: self.mTextField.text)
//    var b = person.save(STORAGE_KEY)
    
    return true
  }
  
  func saveUserInput(str: String) {
//    self.saveUserdefault(str, forKey: STORAGE_KEY)
//    self.saveToFile(str, file: STORAGE_KEY)
    
    self.saveJsonToFile(str, file: STORAGE_KEY)
  }
  
  func retrieveUserInput() -> String? {
//    return self.retrieveUserdefault(STORAGE_KEY)
//    return self.retrieveFromFile(STORAGE_KEY)
    return self.retrieveJsonFromFile(STORAGE_KEY)
  }
  
  func deleteUserInput() {
//    self.deleteUserDefault(STORAGE_KEY)
    self.deleteFile(STORAGE_KEY)
  }
  
  let userDefaults = NSUserDefaults.standardUserDefaults()
  func saveUserdefault(data: AnyObject, forKey: String) {
    userDefaults.setObject(data, forKey: forKey)
    userDefaults.synchronize()
  }
  
  func retrieveUserdefault(key: String) -> String? {
    var obj = userDefaults.stringForKey(key)
    return obj
  }
  
  func deleteUserDefault(key: String) {
    self.userDefaults.removeObjectForKey(key)
  }
  
  // using NSFileManager
  let fileMgr = NSFileManager.defaultManager()
  func saveToFile(str: String, file: String) {
    var path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(file)
//    var data = str.dataUsingEncoding(NSUTF8StringEncoding)
//    var ok = fileMgr.createFileAtPath(path, contents: data, attributes: nil)
    
    var error: NSErrorPointer?
    str.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: error!)
  }
  
  func retrieveFromFile(file: String) -> String? {
    var path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(file)
//    var data = fileMgr.contentsAtPath(path)
//    var str = NSString(data:data, encoding: NSUTF8StringEncoding)
    var error: NSError?
//    var str = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: error!)
    
    var str = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
    
    return str
  }
  
  func deleteFile(file: String) {
    var path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(file)
//    var ok = fileMgr.removeItemAtPath(path, error: nil)
  }
  
  let KEY_JSON = "aKey"
  func saveJsonToFile(str: String, file: String) {
    var path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(file)
    // one enry dict, for sure can be more
    var json = NSDictionary(objects: [str], forKeys: [KEY_JSON])
    json.writeToFile(path, atomically: true)
  }
  
  func retrieveJsonFromFile(file: String) -> String? {
    var path = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(file)
    var ser = NSDictionary(contentsOfFile: path)!
    return ser[KEY_JSON] as String?
  }
  
}

//class Person: NSCoding {
//  let KEY_NAME = "name"
//  var name: String = ""
//  
//  init(name: String) {
//    self.name = name
//  }
//  
//  init(coder aDecoder: NSCoder!) {// NS_DESIGNATED_INITIALIZER
//    self.name = aDecoder.decodeObjectForKey(KEY_NAME) as String
//  }
//  
//  func encodeWithCoder(aCoder: NSCoder!) {
//    aCoder.encodeObject(self.name, forKey: KEY_NAME)
//  }
//
//  func save(key: String) -> Bool {
////          NSString* folderpath = [[NSString stringWithFormat:@"~/Documents/%@", folder] stringByExpandingTildeInPath];
//    var path = ("~/Documents/" + key).stringByExpandingTildeInPath
//    var ok = NSKeyedArchiver.archiveRootObject(self, toFile: path)
//    return ok
//  }
//  
//  class func load(key: String) -> Person? {
//    var path = ("~/Documents/" + key).stringByExpandingTildeInPath
//    var obj = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as Person
//    return obj as Person
//  }
//}



