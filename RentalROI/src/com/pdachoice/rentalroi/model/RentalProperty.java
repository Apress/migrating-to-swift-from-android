package com.pdachoice.rentalroi.model;

import java.io.Serializable;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.content.SharedPreferences;

public class RentalProperty implements Serializable {

  private static final long serialVersionUID = 1L;
  
  private double purchasePrice;
  private double loanAmt;
  private double interestRate;
  private int numOfTerms;
  private double escrow;
  private double extra;
  private double expenses;
  private double rent;

  public static final String KEY_AMO_SAVED = "KEY_AMO_SAVED";
  public static final String KEY_PROPERTY = "KEY_PROPERTY";
  private static final String PREFS_NAME = "MyPrefs";
  private static final int MODE = Context.MODE_PRIVATE; // MODE_WORLD_WRITEABLE

  private static RentalProperty _sharedInstance = null;

  private RentalProperty() {
    super();
    this.interestRate = 5.0f;
    this.numOfTerms = 30;
  }

  public static RentalProperty sharedInstance() {
    if (_sharedInstance == null) {
      _sharedInstance = new RentalProperty();
    }
    return _sharedInstance;
  }

  public String getAmortizationPersistentKey() {    
    String aKey = String.format("%.2f-%.3f-%d-%.2f",
        this.loanAmt, this.interestRate, this.numOfTerms, this.extra);
    return aKey;
  }

  public JSONArray getSavedAmortization(Context activity) {
    String savedKey = retrieveSharedPref(KEY_AMO_SAVED, activity);
    String aKey = this.getAmortizationPersistentKey();
    if(savedKey.length() > 0 && savedKey.equals(aKey)) {
      String jsonArrayString = retrieveSharedPref(savedKey, activity);
      try {
        return new JSONArray(jsonArrayString);
      } catch (JSONException e) {
        return null;
      }
    } else {
       return null;
    }  
  }

  public void saveAmortization(String data, Context activity) {
    String aKey = this.getAmortizationPersistentKey();
    saveSharedPref(KEY_AMO_SAVED, aKey, activity);
    saveSharedPref(aKey, data, activity);
  }

  public boolean load(Context activity) {
   
    String jostr = retrieveSharedPref(KEY_PROPERTY, activity);
    if(jostr == null) {
      return false;
    }
    
    try {
      JSONObject jo = new JSONObject(jostr);
      this.purchasePrice = jo.getDouble("purchasePrice");
      this.loanAmt = jo.getDouble("loanAmt");
      this.interestRate = jo.getDouble("interestRate");
      this.numOfTerms = jo.getInt("numOfTerms");
      this.escrow = jo.getDouble("escrow");
      this.extra = jo.getDouble("extra");
      this.expenses = jo.getDouble("expenses");
      this.rent = jo.getDouble("rent");
      return true;
    } catch (JSONException e) {
      e.printStackTrace();
      return false;
    }
  }

  public boolean save(Context activity) {
    JSONObject jo = new JSONObject();
    
    try {
      jo.put("purchasePrice", purchasePrice);
      jo.put("loanAmt", loanAmt);
      jo.put("interestRate", interestRate);
      jo.put("numOfTerms", numOfTerms);
      jo.put("escrow", escrow);
      jo.put("extra", extra);
      jo.put("expenses", expenses);
      jo.put("rent", rent);
    } catch (JSONException e) {
      e.printStackTrace();
    }

    return this.saveSharedPref(KEY_PROPERTY, jo.toString(), activity);
  }

  ///////// SharedPreferences usage /////////////////
  public boolean saveSharedPref(String key, String data, Context activity) {
    // get a handle to SharedPreferences object from Context, i.e., Activity
    SharedPreferences sharedPrefs = activity.getSharedPreferences(
        PREFS_NAME, MODE);
    // We need an Editor object to make preference changes.
    SharedPreferences.Editor editor = sharedPrefs.edit();
    // changes are cached in Editor first.
    editor.putString(key, data);
    // Commit all the changes from Editor all at once.
    return editor.commit();
  }

  public String retrieveSharedPref(String key, Context activity) {
    // get a handle to SharedPreferences object from Context.
    SharedPreferences sharedPrefs = activity.getSharedPreferences(
        PREFS_NAME, MODE);
    // use appropriate API to get the value by key.
    String data = sharedPrefs.getString(key, "");
    return data;
  }

  public void deleteSharedPref(String key, Context activity) {
    SharedPreferences sharedPrefs = activity.getSharedPreferences(
        PREFS_NAME, MODE);

    SharedPreferences.Editor editor = sharedPrefs.edit();
    editor.remove(key);
    editor.commit();
  }

  // java fields public accessors
  public double getPurchasePrice() {
    return purchasePrice;
  }

  public void setPurchasePrice(double purchasePrice) {
    this.purchasePrice = purchasePrice;
  }

  public double getLoanAmt() {
    return loanAmt;
  }

  public void setLoanAmt(double loanAmt) {
    this.loanAmt = loanAmt;
  }

  public double getInterestRate() {
    return interestRate;
  }

  public void setInterestRate(double interestRate) {
    this.interestRate = interestRate;
  }

  public int getNumOfTerms() {
    return numOfTerms;
  }

  public void setNumOfTerms(int numOfTerms) {
    this.numOfTerms = numOfTerms;
  }

  public double getEscrow() {
    return escrow;
  }

  public void setEscrow(double escrow) {
    this.escrow = escrow;
  }

  public double getExtra() {
    return extra;
  }

  public void setExtra(double extra) {
    this.extra = extra;
  }

  public double getExpenses() {
    return expenses;
  }

  public void setExpenses(double expenses) {
    this.expenses = expenses;
  }

  public double getRent() {
    return rent;
  }

  public void setRent(double rent) {
    this.rent = rent;
  }
  
}
