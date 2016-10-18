//
//  ViewController.swift
//  Dialogs
//
//  Created by Sean on 7/14/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverControllerDelegate {
                            
  @IBOutlet weak var mPopupButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func doPopup(sender: AnyObject) {
    self.performSegueWithIdentifier("mypopover", sender: nil)
    
//    var nav = self.storyboard.instantiateViewControllerWithIdentifier("nav") as UIViewController
//    var popover =   UIPopoverController(contentViewController: nav)
//    popover.delegate = self;
//    popover.popoverContentSize = nav.view.bounds.size
//    popover.presentPopoverFromRect(self.mPopupButton.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
  }
  

  @IBAction func doAlertDeprecated(sender: AnyObject) {
    
    // SDK bug ??
    //  let alert = UIAlertView(title: "", message: "", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok", "", "")
    
//    let alert = UIAlertView()
//    alert.title = "My title"
//    alert.message = "My message"
//    alert.addButtonWithTitle("Cancel")
//    alert.addButtonWithTitle("Ok")
//    alert.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
//    alert.show()
//    
//    alert.delegate = self
    
  }
  
  @IBAction func doAlert(sender: AnyObject) {
    
    var alert = UIAlertController(title: "My title", message: "My message", preferredStyle: .Alert)
    
    // add action buttons
    var actionCancel = UIAlertAction(title: "Cancel", style: .Cancel,
      handler: {action in
        // do nothing
      })
    
    var actionOk = UIAlertAction(title: "Ok", style: .Default,
      handler: {action in
        println((alert.textFields![0] as UITextField).text)
      })
    
    alert.addAction(actionCancel)
    alert.addAction(actionOk)
    
    // add text fields
    alert.addTextFieldWithConfigurationHandler({textField in
      // config the UITextField
      textField.backgroundColor = UIColor.yellowColor()
      textField.placeholder = "enter text, i.e., Do Ra Me"
      })
    
    // regular UIViewController API to show the presented viewController
//    self.presentModalViewController(alert, animated: true)
    
    self.presentViewController(alert, animated: true, completion: nil)
  }
}

class GreenViewController : UIViewController {
  
  @IBAction func doDone(sender: AnyObject) {
    // do something and dismiss
//    self.dismissModalViewControllerAnimated(true)
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

