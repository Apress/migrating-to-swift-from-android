//
//  MonthlyTermViewController.swift
//  RentalROI
//
//  Created by Sean on 9/29/14.
//  Copyright (c) 2014 PdaChoice. All rights reserved.
//

import UIKit
class MonthlyTermViewController : UITableViewController {
  
  @IBOutlet weak var mPaymentNo: UILabel!
  @IBOutlet weak var mTotalPmt: UILabel!
  @IBOutlet weak var mPrincipal: UILabel!
  @IBOutlet weak var mInterest: UILabel!
  @IBOutlet weak var mEscrow: UILabel!
  @IBOutlet weak var mAddlPmt: UILabel!
  @IBOutlet weak var mBalance: UILabel!
  @IBOutlet weak var mEquity: UILabel!
  @IBOutlet weak var mCashInvested: UILabel!
  @IBOutlet weak var mRoi: UILabel!
  
  ///// from Java counterpart
  // private JSONObject monthlyTerm;
  var monthlyTerm = NSDictionary()
  
  //// IBOutlets above, and super.view
  // private TextView mPaymentNo;
  // private TextView mTotalPmt;
  // private TextView mPrincipal;
  // private TextView mInterest;
  // private TextView mEscrow;
  // private TextView mAddlPmt;
  // private TextView mBalance;
  // private TextView mEquity;
  // private TextView mCashInvested;
  // private TextView mRoi;
  // private View contentView;
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var principal = self.monthlyTerm["principal"] as Double
    var interest = self.monthlyTerm["interest"] as Double
    var escrow = self.monthlyTerm["escrow"] as Double
    var extra = self.monthlyTerm["extra"] as Double
    var balance = (self.monthlyTerm["balance0"] as Double) - principal
    var paymentPeriod = self.monthlyTerm["pmtNo"] as Int
    var totalPmt = principal + interest + escrow + extra
    self.mTotalPmt.text = NSString(format: "$%.2f", totalPmt)
    self.mPaymentNo.text = NSString(format: "No. %d", paymentPeriod)
    self.mPrincipal.text = NSString(format: "$%.2f", principal)
    self.mInterest.text = NSString(format: "$%.2f", interest)
    self.mEscrow.text = NSString(format: "$%.2f", escrow)
    self.mAddlPmt.text = NSString(format: "$%.2f", extra)
    self.mBalance.text = NSString(format: "$%.2f", balance)
    
    var property = RentalProperty.sharedInstance();
    var invested = property.getPurchasePrice() - property.getLoanAmt() + (property.getExtra() * Double(paymentPeriod))
    var net = property.getRent() - escrow - interest - property.getExpenses();
    var roi = net * 12 / invested
    
    self.mEquity.text = NSString(format: "$%.2f", property.getPurchasePrice() - balance)
    self.mCashInvested.text = NSString(format: "$%.2f", invested)
    self.mRoi.text = NSString(format: "%.2f%% ($%.2f/mo)", roi * 100, net)
  }
  
  override func viewDidAppear(animated: Bool) {
    //  super.onResume();
    //  ((MainActivity) getActivity()).slideIn(contentView, MainActivity.SLIDE_LEFT);
    //  getActivity().setTitle(getText(R.string…));
    
    super.viewDidAppear(animated)
  }
  
  // JavaBean accessors => not needed with Swift properties
}
