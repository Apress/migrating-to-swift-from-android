//
//  RentalPropertyViewFragment.swift
//  RentalROI
//
//  Created by Sean on 9/29/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit

class RentalPropertyViewController : UITableViewController, EditTextViewControllerDelegate  {
  
  ///// from Java counterpart
  //private static let URL_service_tmpl = "http://www.pdachoice.com/ras/service/amortization?loan=%.2f&rate=%.3f&terms=%d&extra=%.2f"
  // private static final String KEY_DATA = "data";
  // private static final String KEY_RC = "rc";
  // private static final String KEY_ERROR = "error";
  struct MyStatic {
    private static let URL_service_tmpl = "http://www.pdachoice.com/ras/service/amortization?loan=%.2f&rate=%.3f&terms=%d&extra=%.2f&escrow=%.2f"
    private static let KEY_DATA = "data"
    private static let KEY_RC = "rc"
    private static let KEY_ERROR = "error"
  }
  
  // private RentalProperty _property;
  // private JSONArray _savedAmortization;
  // private BaseAdapter mAdapter; // pure Android
  var _property = RentalProperty.sharedInstance()
  var _savedAmortization: NSArray?
  
  ///// from Java counterpart
  // @Override public void onCreate(Bundle savedInstanceState) {
  override func viewDidLoad() {
    super.viewDidLoad() // super.onCreate(savedInstanceState);
    _property = RentalProperty.sharedInstance();
    _property.load(/*getActivity()*/);
    //    setHasOptionsMenu(true); // enable Option Menu.
    //    mAdapter = createListAdapter();
    //    this.setListAdapter(mAdapter);
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated) // super.onResume();
    // getActivity().setTitle(getText(R.string.label_property));
    self.navigationItem.title = "Property"
  }
  
  //  @Override public void onCreateOptionsMenu(…) {
  // UINavigationBar already drawn in Storyboard
  
  //  @Override public boolean onOptionsItemSelected(…) {
  @IBAction func doSchedule(sender: AnyObject) {
    //    doAmortization();
    doAmortization()
  }
  
  //// callback method when list item is selected.
  // @Override public void onListItemClick(…) {
  // android adapter to iOS datasource
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return NSLocalizedString("mortgage", comment: "")
    } else {
      return NSLocalizedString("operations", comment: "")
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 7
    } else {
      return 2
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("aCell", forIndexPath: indexPath) as UITableViewCell
    var textLabel = cell.textLabel
    var detailTextLabel = cell.detailTextLabel!
    
    var pos = indexPath.row
    var section = indexPath.section
    
    if section == 0 {
      pos = indexPath.row + 1
    } else { // 1
      pos = indexPath.row + 9
    }
    
    switch (pos) {
    case 1:
      textLabel.text = NSLocalizedString("purchasePrice", comment: "")
      detailTextLabel.text = NSString(format: "%.0f", _property.getPurchasePrice());
    case 2:
      textLabel.text = NSLocalizedString("downPayment", comment: "")
      
      if (_property.getPurchasePrice() > 0) {
        var down = (1 - _property.getLoanAmt() / _property.getPurchasePrice()) * 100.0;
        detailTextLabel.text = NSString(format: "%.0f", down);
        
        if (_property.getLoanAmt() == 0 && down > 0) {
          _property.setLoanAmt(_property.getPurchasePrice() * (1 - down / 100.0));
        }
      } else {
        detailTextLabel.text = "0";
      }
    case 3:
      textLabel.text = NSLocalizedString("loanAmount", comment: "")
      detailTextLabel.text = NSString(format: "%.2f", _property.getLoanAmt())
    case 4:
      textLabel.text = NSLocalizedString("interestRate", comment: "")
      detailTextLabel.text = NSString(format: "%.3f", _property.getInterestRate())
    case 5:
      textLabel.text = NSLocalizedString("mortgageTerm", comment: "")
      detailTextLabel.text = NSString(format: "%d", _property.getNumOfTerms())
    case 6:
      textLabel.text = NSLocalizedString("escrowAmount", comment: "")
      detailTextLabel.text = NSString(format: "%.0f", _property.getEscrow())
    case 7:
      textLabel.text = NSLocalizedString("extraPayment", comment: "")
      detailTextLabel.text = NSString(format: "%.0f", _property.getExtra());
    case 9:
      textLabel.text = NSLocalizedString("expenses", comment: "")
      detailTextLabel.text = NSString(format: "%.0f", _property.getExpenses());
    case 10:
      textLabel.text = NSLocalizedString("rent", comment: "")
      detailTextLabel.text = NSString(format: "%.0f", _property.getRent());
      
    default:
      break;
    }
    
    return cell
  }
  
  //// callback method when list item is selected.
  // @Override public void onListItemClick(ListView l, View v, int position, long id) {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // ((MainActivity) getActivity()).pushViewController(toFrag, true);
    self.performSegueWithIdentifier("EditText", sender: indexPath)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var identifier = segue.identifier
    if identifier == "EditText" {
      var indexPath = sender as NSIndexPath
      
      // if (position == 0 || position == 8) {
      // return; // position 0 and 8 are header
      // }
      // EditTextViewFragment toFrag = new EditTextViewFragment();
      var toFrag =  (segue.destinationViewController as UINavigationController).topViewController as EditTextViewController
      // NameValuePair data = (NameValuePair) mAdapter.getItem(position);
      var cell = tableView.cellForRowAtIndexPath(indexPath)!
      var row = indexPath.row
      var section = indexPath.section
      // toFrag.setEditTextTag(position);
      // toFrag.setHeader(data.getName());
      // toFrag.setText(data.getValue());
      // toFrag.setDelegate(this);
      toFrag.editTextTag = (section == 0) ? row + 1 : row + 9
      toFrag.header = cell.textLabel.text!
      toFrag.text = cell.detailTextLabel!.text!
      toFrag.delegate = self
    } else { // AmortizationTable segue
      // AmortizationViewFragment toFrag = new AmortizationViewFragment();
      // toFrag.setMonthlyTerms(_savedAmortization);
      var toFrag = segue.destinationViewController as AmortizationViewController
      toFrag.monthlyTerms = sender as NSArray
    }
  }
  
  //// delegate interface
  // public void onTextEditSaved(int tag, String text) {
  func onTextEditSaved(tag: Int, text: String) {
    //  ((MainActivity) getActivity()).popViewController();
    self.dismissViewControllerAnimated(true, completion: nil)
    
    switch (tag) {
    case 1:
      _property.setPurchasePrice((text as NSString).doubleValue);
      //    String percent = ((NameValuePair) mAdapter.getItem(2)).getValue();
      var indexPath = (tag < 9) ? NSIndexPath(forRow: tag - 1, inSection: 0) : NSIndexPath(forRow: tag - 9, inSection: 1)
      var percent = tableView.cellForRowAtIndexPath(indexPath)!.detailTextLabel!.text!
      var down = (percent as NSString).doubleValue
      if (_property.getPurchasePrice() > 0 && _property.getLoanAmt() == 0 && down > 0) {
        _property.setLoanAmt(_property.getPurchasePrice() * (1 - down / 100.0));
      }
      
      break;
    case 2:
      var percentage = (text as NSString).doubleValue / 100.0;
      _property.setLoanAmt(_property.getPurchasePrice() * (1 - percentage));
      break;
    case 3:
      _property.setLoanAmt((text as NSString).doubleValue);
      break;
    case 4:
      _property.setInterestRate((text as NSString).doubleValue);
      break;
    case 5:
      _property.setNumOfTerms((text as NSString).integerValue);
      break;
    case 6:
      _property.setEscrow((text as NSString).doubleValue);
      break;
    case 7:
      _property.setExtra((text as NSString).doubleValue);
      break;
    case 9:
      _property.setExpenses((text as NSString).doubleValue);
      break;
    case 10:
      _property.setRent((text as NSString).doubleValue);
      break;
      
    default:
      break;
    }
    tableView.reloadData() // mAdapter.notifyDataSetChanged();
    _property.save(/* getActivity() */);
  }
  
  func onTextEditCanceled() {
    //  ((MainActivity) getActivity()).popViewController();
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // public void doAmortization(Object sender) {
  private func doAmortization() {
    _savedAmortization = _property.getSavedAmortization();
    if (_savedAmortization != nil) {
      performSegueWithIdentifier("AmortizationTable", sender: _savedAmortization!)
    } else {
      var url = NSString(format: MyStatic.URL_service_tmpl, _property.getLoanAmt(), _property.getInterestRate(), _property.getNumOfTerms(), _property.getExtra(), _property.getEscrow())
      UIApplication.sharedApplication().networkActivityIndicatorVisible = true
      
      var urlRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
      urlRequest.HTTPMethod = "GET"
      urlRequest.setValue("text/html",forHTTPHeaderField: "accept")
      NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(),
        completionHandler: {(resp: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
          NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(resp: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
              UIApplication.sharedApplication().networkActivityIndicatorVisible = false
              var errMsg: String?
              if error == nil {
                var statusCode = (resp as NSHTTPURLResponse).statusCode
                if(statusCode == 200) {
                  var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                  var parseErr: NSError?
                  var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parseErr) as NSArray?
                  if parseErr == nil {
                    self._property.saveAmortization(json!)
                    self.performSegueWithIdentifier("AmortizationTable", sender: json!)
                    return
                  } else {
                    errMsg = parseErr?.debugDescription
                  }
                } else {
                  errMsg = "HTTP RC: \(statusCode)"
                }
              } else {
                errMsg = error.debugDescription
              }
              
              // show error
              var alert = UIAlertController(title: "Error", message: errMsg, preferredStyle: UIAlertControllerStyle.Alert)
              var actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
                handler: {action in
                  // do nothing
              })
              alert.addAction(actionCancel)
              self.presentViewController(alert, animated: true, completion: nil)
          })
      })
    }
  }
  
  //// GET data from url
  // private JSONObject httpGet(String myurl) {
  private func httpGet(myurl: String) -> NSDictionary? {
    // Commented Java code ommitted
    return [:]
  }
  
  // private String readStream(InputStream stream) {
  func readStream(stream: NSInputStream) -> String {
    // Commented Java code ommitted
    return ""
  }
  
  
}
