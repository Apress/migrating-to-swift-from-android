//
//  ViewController.swift
//  Segues
//
//  Created by Sean on 7/9/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onButtonTouchDown(sender: AnyObject) {
    
    self.performSegueWithIdentifier(
      "manualSegue", sender: sender) // storyboard segue id
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    var identifier = segue.identifier
    var destVc = (segue.destinationViewController as PresentedViewController)
    destVc.data = "some data from presenting vc \(identifier)"
  }
}

