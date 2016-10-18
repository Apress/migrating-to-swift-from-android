package com.pdachoice.rentalroi;

import org.json.JSONArray;
import org.json.JSONObject;

import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.google.analytics.tracking.android.EasyTracker;
import com.google.analytics.tracking.android.Fields;
import com.google.analytics.tracking.android.MapBuilder;

public class AmortizationViewFragment extends ListFragment {
  
  private JSONArray monthlyTerms;
  private BaseAdapter mAdapter;
  
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    mAdapter = new BaseAdapter() {

      @Override
      public View getView(int pos, View view, ViewGroup parent) {        
        if (view == null) { // check null first before recycled object.
          view = getActivity().getLayoutInflater().inflate(R.layout.monthlyterm_listitem, null);
        }
        TextView textLabel = (TextView) view.findViewById(R.id.textLabel);
        TextView detailTextLabel = (TextView) view.findViewById(R.id.detailTextLabel);

        JSONObject monthlyTerm = (JSONObject) monthlyTerms.opt(pos);       
        int pmtNo = monthlyTerm.optInt("pmtNo");
        double balance0 = monthlyTerm.optDouble("balance0");
        textLabel.setText(String.format("%d\t$%.2f", pmtNo, balance0));

        double interest = monthlyTerm.optDouble("interest");
        double principal = monthlyTerm.optDouble("principal");
        detailTextLabel.setText(String.format("Interest: %.2f\tPrincipal: %.2f", interest, principal)); 
        return view;        
      }

      @Override
      public int getCount() {
        return monthlyTerms.length();
      }

      @Override
      public Object getItem(int pos) {
        JSONObject monthlyTerm = (JSONObject) monthlyTerms.opt(pos);
        return monthlyTerm;
      }

      @Override
      public long getItemId(int pos) {
        return pos;
      }

    };
    this.setListAdapter(mAdapter);    
  }
  
  @Override
  public void onResume() {
      super.onResume();
      ((MainActivity) getActivity()).slideIn(getView(), MainActivity.SLIDE_LEFT); 

      getActivity().setTitle(getText(R.string.label_Amortization));     
      EasyTracker tracker =  EasyTracker.getInstance(getActivity());
      tracker.set(Fields.SCREEN_NAME, this.getClass().getSimpleName());
      tracker.send(MapBuilder.createAppView().build());
  }
  
  public void onListItemClick(ListView l, View v, int position, long id) {
    MonthlyTermViewFragment toFrag = new MonthlyTermViewFragment();

    JSONObject jo = (JSONObject) mAdapter.getItem(position);
    toFrag.setMonthlyTerm(jo);

    ((MainActivity) getActivity()).pushViewController(toFrag, true);
  }

  // public accessor
  public JSONArray getMonthlyTerms() {
    return monthlyTerms;
  }

  public void setMonthlyTerms(JSONArray monthlyTerms) {
    this.monthlyTerms = monthlyTerms;
  }
}