//
//  EditTextViewController.swift
//  RentalROI
//
//  Created by Sean on 9/29/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

// Java interface to Swift protocol
protocol EditTextViewControllerDelegate {
  func onTextEditSaved(tag: Int, text: String);
  func onTextEditCanceled();
}

class EditTextViewController : UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var mEditText: UITextField!
  
  //// inner interface
  //  interface EditTextViewControllerDelegate {
  //    public void onTextEditSaved(int tag, String text);
  //    public void onTextEditCanceled();
  //  }
  
  // private int editTextTag;
  // private String header;
  // private String text;
  // private EditTextViewControllerDelegate delegate;
  // private View contentView; => in super.view already
  // private EditText mEditText; => existing IBOutlet
  var editTextTag = 0
  var header = ""
  var text = ""
  var delegate: EditTextViewControllerDelegate!
  
  
  override func viewDidLoad() {
    //  contentView = inflater.inflate(R.layout.edittextview_fragment, container, false);
    //  setHasOptionsMenu(true); // enable Option Menu.
    //  mEditText = (EditText) contentView.findViewById(R.id.tfEditText);
    //  this.mEditText.setText(this.text);
    //  return contentView;
    super.viewDidLoad()
    mEditText.text = self.text
    
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      NSNotificationCenter.defaultCenter().addObserver(self,
        selector: "keyboardAppeared:", name: UIKeyboardDidShowNotification, object: nil)
    }
  }
  
  //  @Override
  //  public void onResume() {
  //    super.onResume();
  //    ((MainActivity) getActivity()).slideIn(contentView, MainActivity.SLIDE_UP); // or SLIDE_LEFT
  //    showKeyboard();
  //    getActivity().setTitle(header);
  //  }
  override func viewDidAppear(animated: Bool) {
    //    super.onResume();
    //    ((MainActivity) getActivity()).slideIn(contentView, MainActivity.SLIDE_UP); // or SLIDE_LEFT
    //    showKeyboard();
    //    getActivity().setTitle(header);
    super.viewDidAppear(animated)
    showKeyboard()
    self.navigationItem.title = self.header
  }
  
  //  @Override
  //  public void onPause() {
  //    super.onPause();
  //    hideKeyboard();
  //  }
  override func viewWillDisappear(animated: Bool) {
    //    super.onPause();
    //    hideKeyboard();
    super.viewWillDisappear(animated)
    hideKeyboard()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func keyboardAppeared(notification: NSNotification) {
    var keyboardInfo = notification.userInfo as NSDictionary!
    var kbFrame = keyboardInfo.valueForKey(UIKeyboardFrameBeginUserInfoKey) as NSValue
    var kbFrameRect: CGRect = kbFrame.CGRectValue()
    var keyboardH = min(kbFrameRect.size.width, kbFrameRect.size.height)
    var screenRect: CGRect = UIScreen.mainScreen().bounds
    
    var tfRect: CGRect = self.mEditText.frame
    var y = screenRect.size.height - keyboardH - mEditText.frame.size.height - 20;
    var x = (screenRect.size.width - tfRect.size.width) / 2
    
    UIView.animateWithDuration(0.1, animations: { () -> Void in
      var newRect = CGRectMake(x, y, tfRect.size.width, tfRect.size.height);
      self.mEditText.frame = newRect
      })
  }
  
  //  @Override
  //  public boolean onOptionsItemSelected(…) {
  //  String returnText = this.mEditText.getText().toString();
  //  if(delegate != null) {
  //  this.delegate.onTextEditSaved(this.getEditTextTag(), returnText);
  //  }
  //  return true;
  //  }
  @IBAction func doSave(sender: AnyObject) {
    var returnText = self.mEditText.text
    if(delegate != nil) {
      delegate.onTextEditSaved(self.editTextTag, text: returnText)
    }
  }
  
  @IBAction func doCancel(sender: AnyObject) {
    if(delegate != nil) {
      delegate.onTextEditCanceled()
    }
  }
  
  private func showKeyboard() {
    //    InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
    //    imm.showSoftInput(mEditText, InputMethodManager.SHOW_IMPLICIT);
    mEditText.selectAll(self);
    self.mEditText.becomeFirstResponder()
  }
  
  private func hideKeyboard() {
    //  InputMethodManager imm = (InputMethodManager) ... ;
    //  imm.hideSoftInputFromWindow(...);
    self.mEditText.endEditing(true)
  }
  // public accessors, not needed in Swift
  // public accessors, not needed in Swift
  
}
