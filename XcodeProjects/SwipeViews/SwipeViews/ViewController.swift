//
//  ViewController.swift
//  SwipeViews
//
//  Created by Sean on 7/13/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class ParentViewController : UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

  @IBOutlet weak var mPageView: UIView!
  var mPageViewController: UIPageViewController!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        
    // 1. initialize page view controller, view and gestures
    self.mPageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    self.mPageViewController.view.frame = self.mPageView.bounds
    self.mPageView.gestureRecognizers = self.mPageViewController.gestureRecognizers
    
    // 2. set data source and delegate
    self.mPageViewController!.delegate = self
    self.mPageViewController!.dataSource = self

    // 3. set the first page
    var vc = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as PageContentViewController
    vc.data = self.items[0]
    vc.pageNo = 0
    self.mPageViewController.setViewControllers([vc], direction: .Forward, animated: false, completion: nil)
    
    // 4. establish parent-child view and view controller heirachy
    self.mPageView.addSubview(self.mPageViewController.view)
    self.addChildViewController(self.mPageViewController)
    self.mPageViewController.didMoveToParentViewController(self)
    
    UIPageControl.appearance().backgroundColor = UIColor.whiteColor()
    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.redColor()
    UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGrayColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // implement data source
  let items = ["Page: 1", "Page: 2", "Page: 3"]
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

    var pageNo = (viewController as PageContentViewController).pageNo
    if pageNo > 0 {
      var vc = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as PageContentViewController
      vc.data = self.items[pageNo-1]
      vc.pageNo = pageNo - 1
      return vc
    }
    
    return nil
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

    var pageNo = (viewController as PageContentViewController).pageNo
    if pageNo < self.items.count - 1 {
      var vc = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as PageContentViewController
      vc.data = self.items[pageNo+1]
      vc.pageNo = pageNo + 1
      return vc
    }
    
    return nil
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return self.items.count
  }
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return (pageViewController.viewControllers[0] as PageContentViewController).pageNo
  }
  
  // implement delegate
//  func pageViewController(pageViewController: UIPageViewController!, willTransitionToViewControllers pendingViewControllers: AnyObject[]!)
//  func pageViewController(pageViewController: UIPageViewController!, didFinishAnimating finished: Bool, previousViewControllers: AnyObject[]!, transitionCompleted completed: Bool)
//  func pageViewController(pageViewController: UIPageViewController!, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation
//  func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController!) -> Int
//  func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: UIPageViewController!) -> UIInterfaceOrientation
  
}

class PageContentViewController: UIViewController {
  
  @IBOutlet weak var textLabel : UILabel!

  var data = ""
  var pageNo = 0
  
  override func viewDidLoad() {
    self.textLabel.text = data
  }
  
}

