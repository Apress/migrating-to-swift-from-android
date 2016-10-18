//
//  ViewController.swift
//  MasterDetail
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
  
}

class MasterTableViewController : UITableViewController {
  var items = ["item 1", "item 2", "item 3"]
  
  @IBAction func doAdd(sender: AnyObject) {
    self.items.append("item \(self.items.count + 1)")
    self.tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("mycell") as UITableViewCell
    cell.textLabel.text = self.items[indexPath.row]
    cell.imageView.image = UIImage(named: "pointer.png")
    cell.accessoryType = UITableViewCellAccessoryType.DetailButton
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("detail", sender: indexPath.row)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    var destVc = segue.destinationViewController as ViewController
    destVc.navigationItem.title = self.items[sender as Int]
  }
}

//
class MasterTableViewController2 : UIViewController, UITableViewDataSource, UITableViewDelegate {
  var items = ["item 1", "item 2", "item 3"]
  
  @IBOutlet weak var tableView: UITableView!
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("mycell") as UITableViewCell
    cell.textLabel.text = self.items[indexPath.row]
    cell.detailTextLabel
    cell.imageView.image = UIImage(named: "pointer.png")
    cell.accessoryType = UITableViewCellAccessoryType.DetailButton
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("detail", sender: indexPath.row)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    var destVc = segue.destinationViewController as ViewController
    destVc.navigationItem.title = self.items[sender as Int]
  }
}

