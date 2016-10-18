//
//  ViewController.swift
//  TabbedApp
//
//  Created by Sean on 7/11/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
                            
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    (self.tabBarController!.viewControllers![1] as UIViewController).tabBarItem.badgeValue = "Zzz"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

class SecondViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

class SimpleTabBarController : UITabBarController, UITabBarControllerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.delegate = self
  }
  func tabBarController(tabBarController: UITabBarController!, shouldSelectViewController viewController: UIViewController!) -> Bool {
    // you may do something and return true
    // Or, return false to not to select viewControlle
    return true
  }
  func tabBarController(tabBarController: UITabBarController!, didSelectViewController viewController: UIViewController!) {
    // you may do something
  }
  
}



