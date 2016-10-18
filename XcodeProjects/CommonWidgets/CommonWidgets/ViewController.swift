//
//  ViewController.swift
//  CommonWidgets
//
//  Created by Sean on 7/16/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit
import MediaPlayer


class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet var mLabel: UILabel!
  @IBOutlet var mButton: UIButton!
  
  @IBOutlet var mContainerView: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view, typically from a nib.
    self.initLabel()
    self.useMpMoviePlayerController()
    self.showWebPage(url: "http://www.pdachoice.com/me/webview")
//    self.showWebPage(htmlString: "<H1>Hello webview</H1>")
    
    var leftConstrait = NSLayoutConstraint(
      item: self.mContainerView,
      attribute: NSLayoutAttribute.Leading,
      relatedBy: NSLayoutRelation(rawValue: 0)!,
      toItem: self.view,
      attribute: NSLayoutAttribute.Leading,
      multiplier: 1.0,
      constant: 0)
    self.view.addConstraint(leftConstrait)
    
    var rightConstrait = NSLayoutConstraint(
      item: self.mContainerView,
      attribute: NSLayoutAttribute.Trailing,
      relatedBy: NSLayoutRelation(rawValue: 0)!,
      toItem: self.view,
      attribute: NSLayoutAttribute.Trailing,
      multiplier: 1.0,
      constant: 0)
    self.view.addConstraint(rightConstrait)
  }

  func initLabel() {
    self.mLabel.text = "My simple text label"
    self.mLabel.textColor = UIColor.darkTextColor()
    self.mLabel.textAlignment = NSTextAlignment.Center
    self.mLabel.shadowColor = UIColor.lightGrayColor()
    self.mLabel.shadowOffset = CGSize(width: 2, height: -2)
  }

  @IBOutlet var mTextField: UITextField!
  func textFieldShouldEndEditing(textField: UITextField!) -> Bool { // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    return true
  }

  func textFieldShouldReturn(textField: UITextField!) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  @IBOutlet var mTextView: UITextView!
  func logText(text : String) {
    self.mTextView.text = self.mTextView.text + "\n" + text
    
    // to make sure the last line is visible
    var count = self.mTextView.text.utf16Count // string length
    self.mTextView.scrollRangeToVisible(NSMakeRange(count, 0))
  }
  
  @IBAction func doButtonTouchDown(sender: AnyObject) {
    println(self.mButton.titleForState(UIControlState.Normal))
    self.mButton.setTitle("Click me!", forState: UIControlState.Normal)
    self.logText("Button clicked")
  }
  
  @IBOutlet var mSegmentedController: UISegmentedControl!
  @IBAction func doScValueChanged(sender: AnyObject) {
    var idx = self.mSegmentedController.selectedSegmentIndex
    self.logText("segment \(idx)")

    let center = self.mButton.center
    UIView.animateWithDuration(1, animations: { action in
      
      self.mButton.center = CGPoint(x: center.x, y: center.y / CGFloat(idx + 1))
      self.mButton.alpha = CGFloat(1 / (idx + 1))
      }, completion: { action in
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { action in
          self.mButton.center = center
          }, completion: {  action in
            // do nothing
          })
      })
  }
  
  @IBOutlet var mSlider: UISlider!
  @IBAction func doSliderValueChanged(sender: AnyObject) {
    var value = self.mSlider.value
    self.logText("slider: \(value)")
//    self.mLabelSlider.text = "\(Int(value))"
    
    self.updateProgress(value/100)
  }
  
  @IBOutlet var mActivityIndicator: UIActivityIndicatorView!
  func toggleActivityIndicator() {
    var isAnimating = mActivityIndicator.isAnimating()
    isAnimating ? mActivityIndicator.stopAnimating() : mActivityIndicator.startAnimating()
  }
  
  @IBOutlet var mProgressView: UIProgressView!
  func updateProgress(value: Float) {
    self.mProgressView.progress = value
  }
  
  @IBOutlet var mSwitch: UISwitch!
  @IBAction func doSwitchValueChanged(sender: AnyObject) {
    var isOn = self.mSwitch.on
    self.toggleActivityIndicator()
  }
  
  @IBOutlet var mImageView: UIImageView!
  func setImage(name: String) {
    self.mImageView.image = UIImage(named: name)
  }
  
//  @IBOutlet weak var mBarButton: UIBarButtonItem!
  @IBAction func doBarButtonAction(sender: AnyObject) {
    println(">> doBarButtonDone: ")
    
    var actionSheet = UIAlertController(title: "From BarButtonItem Action", message: "Choose an Action", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    // add action buttons
    var actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
      handler: {action in
      // do nothing
      })
    
    var actionNormal1 = UIAlertAction(title: "Action 1", style: UIAlertActionStyle.Default,
      handler: {action in
        println(">> actionNormal1")
        self.useMpMoviePlayerViewController()
      })
    
    var actionNormal2 = UIAlertAction(title: "Action 2", style: UIAlertActionStyle.Default,
      handler: {action in
        println(">> actionNormal2")
        self.mMoviePlayer.play()
      })
    
    var actionDestruct = UIAlertAction(title: "Destruct", style: UIAlertActionStyle.Destructive,
      handler: {action in
        println(">> actionDestruct")
      })
    
    actionSheet.addAction(actionNormal1)
    actionSheet.addAction(actionNormal2)
    actionSheet.addAction(actionDestruct)
    actionSheet.addAction(actionCancel)
    
    // UIViewController API to presend viewController
    self.presentViewController(actionSheet, animated: true, completion: nil)
  }
  
  @IBOutlet weak var mPickerView: UIPickerView!
  // returns the number of 'columns' to display.
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 2
  }
  
  // returns the # of rows in each component..
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 10
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
    return "(\(component), \(row))"
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    println("\(self.mPickerView.selectedRowInComponent(0))") // before selection
    println("\(self.mPickerView.selectedRowInComponent(0))")
    println("(\(component), \(row))") // current selection
  }
  
  @IBOutlet weak var mVideoView: UIView!
  var mMoviePlayer : MPMoviePlayerController!
  func useMpMoviePlayerController() {
    
    var url = NSURL(string: "http://devimages.apple.com/iphone/samples/bipbop/gear3/prog_index.m3u8")
    self.mMoviePlayer = MPMoviePlayerController(contentURL: url)

    self.mMoviePlayer.shouldAutoplay = false
    self.mMoviePlayer.controlStyle = MPMovieControlStyle.Embedded
    self.mMoviePlayer.setFullscreen(false, animated: true)
    
    self.mMoviePlayer.view.frame = self.mVideoView.bounds
    self.mVideoView.addSubview(self.mMoviePlayer.view)
    
    self.mMoviePlayer.currentPlaybackTime = 2.0
    self.mMoviePlayer.prepareToPlay()
//    self.mMoviePlayer.play() // or, start play
  }
  
  func useMpMoviePlayerViewController() {
//    var filepath = NSBundle.mainBundle().pathForResource("sample.mp4", ofType: nil)
//    var fileUrl = NSURL(fileURLWithPath: filepath)
//    var pvc = MPMoviePlayerViewController(contentURL: fileUrl)
    
    var contentUrl = NSURL(string: "http://devimages.apple.com/iphone/samples/bipbop/gear3/prog_index.m3u8")
    var pvc = MPMoviePlayerViewController(contentURL: contentUrl)
    
    pvc.moviePlayer.shouldAutoplay = false;
    pvc.moviePlayer.repeatMode = MPMovieRepeatMode.One
    
    self.presentViewController(pvc, animated: true, completion: nil)
  }
  
  
//  -(void) prep {
//  //   NSString* urlStr = @"http://devimages.apple.com/iphone/samples/bipbop/gear3/prog_index.m3u8";
//  NSString* urlStr = @"http://pdachoice.com/me/sample_mpeg4.mp4";
//  
//  NSURL* videoUrl = [[NSURL alloc] initWithString: urlStr];
//  self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
//  
//  self.moviePlayerController.shouldAutoplay = NO;
//  self.moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
//  [self.moviePlayerController setFullscreen:NO animated:YES];
//  
//  self.moviePlayerController.view.frame = self.videoView.bounds;
//  [self.videoView addSubview: self.moviePlayerController.view];
//  [self.moviePlayerController prepareToPlay];
//  
//  }
  
  @IBOutlet weak var mWebView: UIWebView!
  func showWebPage(#url: String) {
    var req = NSURLRequest(URL: NSURL(string: url)!)
    self.mWebView.loadRequest(req)
  }
  
  func showWebPage(#htmlString: String) {
    self.mWebView.loadHTMLString(htmlString, baseURL: nil)
  }
  
  // webview delegate protocol
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    // do something, i.e., re-direct, or intercept the user actions, etc.
    return true; // false to stop http request
  }
  func webViewDidStartLoad(webView: UIWebView) {
    // do somehting, i.e., start UIActivityViewIndicator, or progress view.
    self.mActivityIndicator.startAnimating()
  }
  func webViewDidFinishLoad(webView: UIWebView) {
    // do somehting, i.e., stop  UIActivityViewIndicator, or progress view.
    self.mActivityIndicator.stopAnimating()
  }
  func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
    // do something, i.e., show error alert
    self.mActivityIndicator.stopAnimating()
    var alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
}

