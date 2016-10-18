//
//  ViewController.swift
//  MasterGridDetail
//
//  Created by Sean on 7/11/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class SimpleCollectionViewCell : UICollectionViewCell {
  @IBOutlet weak var textLabel: UILabel!
}

class MasterViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
                            
  @IBOutlet weak var mCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // implement UICollectionViewDataSource
  var items = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7"]
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.items.count
  }
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as SimpleCollectionViewCell
    cell.textLabel.text = self.items[indexPath.row]
    cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.whiteColor() : UIColor.lightGrayColor()
    return cell
  }

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  // implement UICollectionViewDelegate
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("detail", sender: self)
  }

}


