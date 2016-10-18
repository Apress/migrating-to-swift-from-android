package com.pdachoice.rentalroi;

import org.json.JSONObject;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.google.analytics.tracking.android.EasyTracker;
import com.google.analytics.tracking.android.Fields;
import com.google.analytics.tracking.android.MapBuilder;
import com.pdachoice.rentalroi.model.RentalProperty;

public class MonthlyTermViewFragment extends Fragment {

  private JSONObject monthlyTerm;

  private TextView mPaymentNo;
  private TextView mTotalPmt;
  private TextView mPrincipal;
  private TextView mInterest;
  private TextView mEscrow;
  private TextView mAddlPmt;
  private TextView mBalance;
  private TextView mEquity;
  private TextView mCashInvested;
  private TextView mRoi;
  
  private View contentView;

  @Override
  public View onCreateView(LayoutInflater inflater, ViewGroup container,
      Bundle savedInstanceState) {
    contentView = inflater.inflate(R.layout.monthlytermview_fragment, container, false);
    
    mPaymentNo = (TextView)contentView.findViewById(R.id.lbPaymentNo);
    mTotalPmt = (TextView)contentView.findViewById(R.id.lbTotalPayment);
    mPrincipal = (TextView)contentView.findViewById(R.id.lbPrincipalPayment);
    mInterest = (TextView)contentView.findViewById(R.id.lbInterestPayment);
    mEscrow = (TextView)contentView.findViewById(R.id.lbEscrowPayment);
    mAddlPmt = (TextView)contentView.findViewById(R.id.lbAddlPayment);
    mBalance = (TextView)contentView.findViewById(R.id.lbMorgageDebt);
    mEquity = (TextView)contentView.findViewById(R.id.lbEquityInvestment);
    mCashInvested = (TextView)contentView.findViewById(R.id.lbCashInvested);
    mRoi = (TextView)contentView.findViewById(R.id.lbRoi);
    
    double principal = this.monthlyTerm.optDouble("principal");
    double interest = this.monthlyTerm.optDouble("interest");
    double escrow = this.monthlyTerm.optDouble("escrow");
    double extra = this.monthlyTerm.optDouble("extra");
    double balance = this.monthlyTerm.optDouble("balance0") - principal;
    int paymentPeriod = this.monthlyTerm.optInt("pmtNo");

    double totalPmt = principal + interest + escrow + extra;

    this.mTotalPmt.setText(String.format("$%.2f", totalPmt));
    this.mPaymentNo.setText(String.format("No. %d", paymentPeriod));
    this.mPrincipal.setText(String.format("$%.2f", principal));
    this.mInterest.setText(String.format("$%.2f", interest));
    this.mEscrow.setText(String.format("$%.2f", escrow));
    this.mAddlPmt.setText(String.format("$%.2f", extra));

    this.mBalance.setText(String.format("$%.2f", balance));

    RentalProperty property = RentalProperty.sharedInstance();
    double invested = property.getPurchasePrice() - property.getLoanAmt() + property.getExtra() * paymentPeriod;
    double net = property.getRent() - escrow - interest - property.getExpenses();
    double roi = net * 12 / invested;

    this.mEquity.setText(String.format("$%.2f", property.getPurchasePrice() - balance));
    this.mCashInvested.setText(String.format("$%.2f", invested));
    this.mRoi.setText(String.format("%.2f%% ($%.2f/mo)", roi * 100, net));
  
    return contentView;
  }
  
  @Override
  public void onResume() {
      super.onResume();
      ((MainActivity) getActivity()).slideIn(contentView, MainActivity.SLIDE_LEFT);

      getActivity().setTitle(getText(R.string.label_monthlydetails));

//      EasyTracker tracker =  EasyTracker.getInstance(getActivity());
//      tracker.set(Fields.SCREEN_NAME, this.getClass().getSimpleName());
//      tracker.send(MapBuilder.createAppView().build());
  }

  
  // copy from iOS counterpart impl file

//  private void viewDidLoad() {}

  // Java bean accessors
  public JSONObject getMonthlyTerm() {
    return monthlyTerm;
  }

  public void setMonthlyTerm(JSONObject monthlyTerm) {
    this.monthlyTerm = monthlyTerm;
  }  
}