//
//  AmortizationViewController.swift
//  RentalROI
//
//  Created by Sean on 9/29/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit
class AmortizationViewController: UITableViewController {
  
  ///// from Java counterpart
  // private JSONArray monthlyTerms;
  // private BaseAdapter mAdapter;
  var monthlyTerms = NSArray()
  
  override func viewDidLoad() {
    //  super.onCreate(savedInstanceState);
    //  mAdapter = new BaseAdapter() {
    //    ...
    //  };
    //  this.setListAdapter(mAdapter);
    super.viewDidLoad()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // @Override public int getCount() {
    //   return monthlyTerms.length();
    // }
    return monthlyTerms.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // @Override public View getView(int pos, View view, ViewGroup parent) {
    //   if (view == null) {
    //     view = getActivity().getLayoutInflater().inflate(…);
    //   }
    //   TextView textLabel = (TextView) view.findViewById(…);
    //   TextView detailTextLabel = (TextView) view.findViewById(…);
    //
    //   JSONObject monthlyTerm =(JSONObject)monthlyTerms.opt(pos);
    //   int pmtNo = monthlyTerm.optInt("pmtNo");
    //   double balance0 = monthlyTerm.optDouble("balance0");
    //   textLabel.setText(String.format("%d\t$%.2f", pmtNo, balance0));
    //
    //   double interest = monthlyTerm.optDouble("interest");
    //   double principal = monthlyTerm.optDouble("principal");
    //   detailTextLabel.setText(String.format("Interest: %.2f\tPrincipal: %.2f", interest, principal));
    //   return view;
    // }
    var cell = tableView.dequeueReusableCellWithIdentifier("aCell") as UITableViewCell!
    var textLabel = cell.textLabel
    var detailTextLabel = cell.detailTextLabel!
    var pos = indexPath.row
    var monthlyTerm = monthlyTerms[pos] as NSDictionary
    var pmtNo = monthlyTerm["pmtNo"] as Int
    var balance0 = monthlyTerm["balance0"] as Double
    textLabel.text = NSString(format: "%d\t $%.2f", pmtNo, balance0)
    
    var interest = monthlyTerm["interest"] as Double
    var principal = monthlyTerm["principal"] as Double
    
    var property = RentalProperty.sharedInstance();
    var invested = property.getPurchasePrice() - property.getLoanAmt() + (property.getExtra() * Double(pmtNo))
    var net = property.getRent() - property.getEscrow() - interest - property.getExpenses();
    var roi = net * 12 / invested
    
    detailTextLabel.text = NSString(format: "Interest: %.2f\tPrincipal: %.2f\t ROI: %.2f", interest, principal, roi * 100);
    
    return cell
  }
  
  override func viewDidAppear(animated: Bool) {
    // super.onResume();
    // ((MainActivity) getActivity()).slideIn(…);
    // getActivity().setTitle(getText(…));
    super.viewDidAppear(animated)
    self.navigationItem.title = NSLocalizedString("label_Amortization", comment: "")
  }
  
  // public void onListItemClick(…) {
  //   MonthlyTermViewFragment toFrag = new MonthlyTermViewFragment();
  //   JSONObject jo = (JSONObject) mAdapter.getItem(position);
  //   toFrag.setMonthlyTerm(jo);
  //   ((MainActivity)getActivity()).pushViewController(toFrag);
  // }
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("MonthlyTerm", sender: indexPath)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var vc = segue.destinationViewController as MonthlyTermViewController
    var row = (sender! as NSIndexPath).row
    vc.monthlyTerm = monthlyTerms[row] as NSDictionary
  }
  
  
}
