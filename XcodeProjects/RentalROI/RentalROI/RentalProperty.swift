//
//  RentalProperty.swift
//  RentalROI
//
//  Created by Sean on 9/29/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import Foundation

public class RentalProperty {
  // TODO: copy the content of RentalProperty.java
  
  // private double purchasePrice;
  // private double loanAmt;
  // private double interestRate;
  // private int numOfTerms;
  // private double escrow;
  // private double extra;
  // private double expenses;
  // private double rent;
  var purchasePrice = 0.0;
  var loanAmt = 0.0;
  var interestRate = 5.0;
  var numOfTerms = 30;
  var escrow = 0.0;
  var extra = 0.0;
  var expenses = 0.0;
  var rent = 0.0;
  
  // public static final String KEY_PROPERTY = "KEY_PROPERTY";
  // private static final String PREFS_NAME = "MyPrefs";
  // private static final int MODE = Context.MODE_PRIVATE; // MODE_WORLD_WRITEABLE
  // private static RentalProperty _sharedInstance = null;
  struct MyStatic {
    static let KEY_AMO_SAVED = "KEY_AMO_SAVED";
    static let KEY_PROPERTY = "KEY_PROPERTY";
    private static let PREFS_NAME = "MyPrefs";
    private static let MODE = 0; // probably Android thing
    private static var _sharedInstance = RentalProperty()
  }

/////////////////////////////////////////////
  
  // private RentalProperty() {
  private init() {
    // Commented Java code ommitted
  }
  
  // public static RentalProperty sharedInstance() {
  class func sharedInstance() -> RentalProperty {
    return MyStatic._sharedInstance
  }
  
  // public String getAmortizationPersistentKey() {
  func getAmortizationPersistentKey() -> String {
    var aKey = String(format: "%.2f-%.3f-%d-%.2f-%.2f", self.loanAmt, self.interestRate, self.numOfTerms, self.escrow, self.extra);
    return aKey;
  }
  
  // public JSONArray getSavedAmortization(Context activity) {
  func getSavedAmortization() -> NSArray? {
    var savedKey = retrieveUserdefault(MyStatic.KEY_AMO_SAVED) as String?
    var aKey = self.getAmortizationPersistentKey()
    if let str = savedKey {
      if(str.utf16Count > 0 && str == aKey) {
        var jo = retrieveUserdefault(str) as NSArray?
        return jo
      }
    }
    return nil
  }
  
  // public boolean saveAmortization(String data, Context activity){
  func saveAmortization(data: NSArray) -> Bool {
    var aKey = self.getAmortizationPersistentKey()
    saveUserdefault(aKey, forKey: MyStatic.KEY_AMO_SAVED)
    return saveUserdefault(data, forKey: aKey)
  }
  
  // public boolean load(Context activity) {
  func load() -> Bool {
    var data = retrieveUserdefault(MyStatic.KEY_PROPERTY) as NSDictionary?
    if var jo = data {
      self.purchasePrice = jo["purchasePrice"] as Double
      self.loanAmt = jo["loanAmt"] as Double
      self.interestRate = jo["interestRate"] as Double
      self.numOfTerms = jo["numOfTerms"]  as Int
      self.escrow = jo["escrow"] as Double
      self.extra = jo["extra"] as Double
      self.expenses = jo["expenses"] as Double
      self.rent = jo["rent"] as Double
      return true;
      
    } else {
      return false
    }
  }
    
  // public boolean save(Context activity) {
  func save() -> Bool {
    var jo : [NSObject : AnyObject] = [
    "purchasePrice": purchasePrice,
    "loanAmt" : loanAmt,
    "interestRate" : interestRate,
    "numOfTerms" : Double(numOfTerms),
    "escrow" : escrow,
    "extra" : extra,
    "expenses" : expenses,
    "rent" : rent]
    
    return self.saveUserdefault(jo, forKey: MyStatic.KEY_PROPERTY)
  }
  
  /////////// SharedPreferences usage /////////////////
  // public boolean saveSharedPref(String key, String data, Context activity) {
  func saveSharedPref(key:String,data:AnyObject)->Bool{
    // Commented Java code ommitted
    return true
  }
  
  // public String retrieveSharedPref(String key, Context activity) {
  func retrieveSharedPref(key: String) -> AnyObject? {
    // Commented Java code ommitted
    return nil
  }
  
  // public void deleteSharedPref(String key,Context activity) {
  func deleteSharedPref(key: String) {
    // Commented Java code ommitted
  }
  
  // JavaBean accessors
  func getPurchasePrice()-> Double {
    return self.purchasePrice;
  }
  
  func setPurchasePrice(purchasePrice: Double) {
    self.purchasePrice = purchasePrice;
  }
  
  func getLoanAmt()-> Double {
    return self.loanAmt;
  }
  
  func setLoanAmt(loanAmt: Double) {
    self.loanAmt = loanAmt;
  }
  
  func getInterestRate()-> Double {
    return self.interestRate;
  }
  
  func setInterestRate(interestRate: Double) {
    self.interestRate = interestRate;
  }
  
  func getNumOfTerms()-> Int {
    return self.numOfTerms;
  }
  
  func setNumOfTerms(numOfTerms: Int) {
    self.numOfTerms = numOfTerms;
  }
  
  func getEscrow()-> Double {
    return self.escrow;
  }
  
  func setEscrow(escrow: Double) {
    self.escrow = escrow;
  }
  
  func getExtra()-> Double {
    return self.extra;
  }
  
  func setExtra(extra: Double) {
    self.extra = extra;
  }
  
  func getExpenses()-> Double {
    return self.expenses;
  }
  
  func setExpenses(expenses: Double) {
    self.expenses = expenses;
  }
  
  func getRent()-> Double {
    return self.rent;
  }
  
  func setRent(rent: Double) {
    self.rent = rent;
  }
  
  let userDefaults = NSUserDefaults.standardUserDefaults()
  func saveUserdefault(data:AnyObject, forKey:String) -> Bool{
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

}