//
//  FromActionSegueViewController.swift
//  Segues
//
//  Created by Sean on 7/9/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit
class PresentedViewController: UIViewController {
  var data: String?
  override func viewDidLoad() {
    if let tmp = data {
      println("received data: \(tmp)")
//      self.navigationItem.title = tmp
    }
    
  }
}
