//
//  HelloViewController.swift
//  HelloMobile
//
//  Created by Sean on 7/8/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {
  
  @IBOutlet weak var mTextField: UITextField!
  @IBOutlet weak var mLabel: UILabel!
  @IBOutlet weak var mButton: UIButton!
  
  @IBAction func onButtonTouchDown(sender: AnyObject) {
    var str = mTextField.text
    mLabel.text = "Hello \(str)!"
  }
}
