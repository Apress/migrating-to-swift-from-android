//
//  ViewController.swift
//  RestClient
//
//  Created by Sean on 7/28/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
  
  @IBOutlet weak var mWebView: UIWebView!
  @IBOutlet weak var mTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldShouldReturn(textField: UITextField!) -> Bool {
    textField.resignFirstResponder();
    return true
  }
  
  let URL_TEST = "http://pdachoice.com/ras/service/echo/"
  @IBAction func doGet(sender: AnyObject) {
    var text = self.mTextField.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
    
    var url = URL_TEST + text!
    var urlRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
    urlRequest.HTTPMethod = "GET"
    urlRequest.setValue("text/html", forHTTPHeaderField: "accept")
    
    NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(),
      completionHandler: {(resp: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        println(resp.MIMEType)
        println(resp.textEncodingName)
        self.mWebView.loadData(data, MIMEType: resp.MIMEType, textEncodingName: resp.textEncodingName, baseURL: nil)
    })
  }
  
  @IBAction func doPost(sender: AnyObject) {
    var text = self.mTextField.text.stringByAddingPercentEncodingWithAllowedCharacters(
      NSCharacterSet.URLQueryAllowedCharacterSet())
    var queryString = "echo=" + text!;
    var formData = queryString.dataUsingEncoding(NSUTF8StringEncoding)!
    var urlRequest = NSMutableURLRequest(URL: NSURL(string: URL_TEST)!)
    urlRequest.HTTPMethod = "POST"
    urlRequest.HTTPBody = formData
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
    
    NSURLConnection.sendAsynchronousRequest(urlRequest,
      queue: NSOperationQueue.mainQueue(),
      completionHandler: {(resp: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//        println(resp.MIMEType)
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
        
        var json = NSJSONSerialization.JSONObjectWithData(data, options:
          NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        var echo = json["echo"] as String
        self.mWebView.loadHTMLString(echo, baseURL: nil)
    })
  }
  
}

