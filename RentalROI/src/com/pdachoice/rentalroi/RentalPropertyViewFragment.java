package com.pdachoice.rentalroi;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.analytics.tracking.android.EasyTracker;
import com.google.analytics.tracking.android.Fields;
import com.google.analytics.tracking.android.MapBuilder;
import com.pdachoice.rentalroi.EditTextViewFragment.EditTextViewControllerDelegate;
import com.pdachoice.rentalroi.model.RentalProperty;

public class RentalPropertyViewFragment extends ListFragment implements EditTextViewControllerDelegate {

  private static final String URL_service_tmpl = "http://www.pdachoice.com/ras/service/amortization?loan=%.2f&rate=%.3f&terms=%d&extra=%.2f";
  private static final String KEY_DATA = "data";
//  private static final String KEY_RC = "rc";
  private static final String KEY_ERROR = "error";

  private RentalProperty _property;
  private JSONArray _savedAmortization;

  private BaseAdapter mAdapter;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    _property = RentalProperty.sharedInstance();
    _property.load(getActivity());
    setHasOptionsMenu(true); // enable Option Menu.
    mAdapter = createListAdapter();
    this.setListAdapter(mAdapter);
  }

  @Override
  public void onResume() {
    super.onResume();
    getActivity().setTitle(getText(R.string.label_property));

    EasyTracker tracker = EasyTracker.getInstance(getActivity());
    tracker.set(Fields.SCREEN_NAME, this.getClass().getSimpleName());
    tracker.send(MapBuilder.createAppView().build());
  }

  @Override
  public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
    super.onCreateOptionsMenu(menu, inflater);
    inflater.inflate(R.menu.main, menu);
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    // Log.d(tag, "onOptionsItemSelected: " + item.getItemId());
    doAmortization();
    // ((MainActivity)getActivity()).pushViewController(new
    // AmortizationViewFragment(), true);
    return true;
  }

  // callback method when list item is selected.
  @Override
  public void onListItemClick(ListView l, View v, int position, long id) {
    // position 0 and 8 are header
    if (position == 0 || position == 8) {
      return;
    }

    EditTextViewFragment toFrag = new EditTextViewFragment();
    NameValuePair data = (NameValuePair) mAdapter.getItem(position);

    toFrag.setEditTextTag(position);
    toFrag.setHeader(data.getName());
    toFrag.setText(data.getValue());
    toFrag.setDelegate(this);

    ((MainActivity) getActivity()).pushViewController(toFrag, true);
  }

  private BaseAdapter createListAdapter() {
    return new BaseAdapter() {

      @Override
      public int getItemViewType(int pos) {
        if (pos == 0 || pos == 8) {
          return 0;
        } else {
          return 1;
        }
      }

      @Override
      public int getViewTypeCount() {
        return 2;
      }

      @Override
      public View getView(int pos, View view, ViewGroup parent) {

        if (view == null) { // check null first before recycled object.
          LayoutInflater inflater = getActivity().getLayoutInflater();
          if (pos == 0 || pos == 8) {
            // header list item
            view = inflater.inflate(android.R.layout.simple_list_item_1, null);
          } else {
            // right detail list item
            view = inflater.inflate(R.layout.rightdetail_listitem, null);
          }
        }

        if (pos == 0 || pos == 8) {
          // header list item
          view.setBackgroundColor(Color.argb(32, 0, 128, 128));
          TextView text1 = (TextView) view.findViewById(android.R.id.text1);

          if (pos == 0) {
            text1.setText(getResources().getString(R.string.morgtage));
          } else {
            text1.setText(getResources().getString(R.string.operations));
          }
        } else {
          // right detail list item
          view.setBackgroundColor(Color.argb(0, 0, 0, 0));
          TextView textLabel = (TextView) view.findViewById(R.id.textLabel);
          TextView detailTextLabel = (TextView) view.findViewById(R.id.detailTextLabel);

          switch (pos) {
          case 1:
            textLabel.setText(R.string.purchasePrice);
            detailTextLabel.setText(String.format("%.0f", _property.getPurchasePrice()));
            break;
          case 2:
            textLabel.setText(R.string.downPayment);
            if (_property.getPurchasePrice() > 0) {
              double down = (1 - _property.getLoanAmt() / _property.getPurchasePrice()) * 100.0;
              detailTextLabel.setText(String.format("%.0f", down));

              if (_property.getLoanAmt() == 0 && down > 0) {
                _property.setLoanAmt(_property.getPurchasePrice() * (1 - down / 100.0));
              }
            } else {
              detailTextLabel.setText("0");
            }
            break;
          case 3:
            textLabel.setText(R.string.loanAmount);
            detailTextLabel.setText(String.format("%.2f", _property.getLoanAmt()));
            break;
          case 4:
            textLabel.setText(R.string.interestRate);
            detailTextLabel.setText(String.format("%.3f", _property.getInterestRate()));
            break;
          case 5:
            textLabel.setText(R.string.mortgageTerm);
            detailTextLabel.setText(String.format("%d", _property.getNumOfTerms()));
            break;
          case 6:
            textLabel.setText(R.string.escrowAmount);
            detailTextLabel.setText(String.format("%.0f", _property.getEscrow()));
            break;
          case 7:
            textLabel.setText(R.string.extraPayment);
            detailTextLabel.setText(String.format("%.0f", _property.getExtra()));
            break;
          case 9:
            textLabel.setText(R.string.expenses);
            detailTextLabel.setText(String.format("%.0f", _property.getExpenses()));
            break;
          case 10:
            textLabel.setText(R.string.rent);
            detailTextLabel.setText(String.format("%.0f", _property.getRent()));
            break;

          default:
            break;
          }
        }

        return view;
      }

      @Override
      public int getCount() {
        return 11; // 2 section + 9 fields
      }

      @Override
      public long getItemId(int pos) {
        return pos; // not used
      }

      @Override
      public Object getItem(int pos) {
        TextView textLabel = (TextView) getView(pos, null, null).findViewById(R.id.textLabel);
        if (textLabel == null) {
          return null;
        } else {
          TextView detailTextLabel = (TextView) getView(pos, null, null).findViewById(R.id.detailTextLabel);
          NameValuePair nvp = new BasicNameValuePair(textLabel.getText().toString(), detailTextLabel.getText().toString());
          return nvp;
        }
      }

    };
  }

  // delegate interface
  public void onTextEditSaved(int tag, String text) {
    ((MainActivity) getActivity()).popViewController();

    switch (tag) {
    case 1:
      _property.setPurchasePrice(Double.parseDouble(text));
      String percent = ((NameValuePair) mAdapter.getItem(2)).getValue();
      double down = Double.parseDouble(percent);
      if (_property.getPurchasePrice() > 0 && _property.getLoanAmt() == 0 && down > 0) {
        _property.setLoanAmt(_property.getPurchasePrice() * (1 - down / 100.0));
      } 

      break;
    case 2:
      double percentage = Double.parseDouble(text) / 100.0;
      _property.setLoanAmt(_property.getPurchasePrice() * (1 - percentage));
      break;
    case 3:
      _property.setLoanAmt(Double.parseDouble(text));
      break;
    case 4:
      _property.setInterestRate(Double.parseDouble(text));
      break;
    case 5:
      _property.setNumOfTerms(Integer.parseInt(text));
      break;
    case 6:
      _property.setEscrow(Double.parseDouble(text));
      break;
    case 7:
      _property.setExtra(Double.parseDouble(text));
      break;
    case 9:
      _property.setExpenses(Double.parseDouble(text));
      break;
    case 10:
      _property.setRent(Double.parseDouble(text));
      break;

    default:
      break;
    }
    mAdapter.notifyDataSetChanged();
    _property.save(getActivity());
  }

  public void onTextEditCanceled() {
    // [self dismissViewControllerAnimated:YES completion:nil];
    ((MainActivity) getActivity()).popViewController();
  }

  private void doAmortization() {
    _savedAmortization = _property.getSavedAmortization(getActivity());
    if (_savedAmortization != null) {
      AmortizationViewFragment toFrag = new AmortizationViewFragment();
      toFrag.setMonthlyTerms(_savedAmortization);
      ((MainActivity) getActivity()).pushViewController(toFrag, true);
    } else {
      String url = String.format(URL_service_tmpl, _property.getLoanAmt(), _property.getInterestRate(), _property.getNumOfTerms(), _property.getExtra());
      getActivity().setProgressBarIndeterminate(true);
      getActivity().setProgressBarVisibility(true);

      AsyncTask<String, Float, JSONObject> task = new AsyncTask<String, Float, JSONObject>() {
        @Override
        protected JSONObject doInBackground(String... parms) {
          String getUrl = parms[0];
          InputStream in = null;
          HttpURLConnection conn = null;

          JSONObject jo = new JSONObject();
          try {
            URL url = new URL(getUrl);
            // create an HttpURLConnection by openConnection
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("accept", "application/json");

            int rc = conn.getResponseCode(); // HTTP status code
            String rm = conn.getResponseMessage(); // HTTP response message.
            Log.d("d", String.format("HTTP GET: %d %s", rc, rm));

            // read message body from connection InputStream
            in = conn.getInputStream();             
            StringBuilder builder = new StringBuilder();
            InputStreamReader reader = new InputStreamReader(in);
            char[] buffer = new char[1024];
            int length;
            while ((length = reader.read(buffer)) != -1) {
                builder.append(buffer, 0, length);
            }            
            in.close();

            String httpBody = builder.toString();
            jo.put(KEY_DATA, httpBody);

          } catch (Exception e) {
            e.printStackTrace();
            try {
              jo.putOpt(KEY_ERROR, e);
            } catch (JSONException e1) {
              e1.printStackTrace();
            }
          } finally {
            conn.disconnect();
          }
          return jo;
        }

        @Override
        protected void onPostExecute(JSONObject jo) {
          getActivity().setProgressBarVisibility(false);
          Exception error = (Exception) jo.opt(KEY_ERROR);
          String errMsg = null;
          if (error == null) {
            AmortizationViewFragment toFrag = new AmortizationViewFragment();
            String data = jo.optString(KEY_DATA);
            _property.saveAmortization(data, getActivity());

            try {
              toFrag.setMonthlyTerms(new JSONArray(data));
              ((MainActivity) getActivity()).pushViewController(toFrag, true);
              return;
            } catch (JSONException e) {
              e.printStackTrace();
              errMsg = e.getMessage();
            }
          } else {
            errMsg = error.getMessage();
          }
          Toast.makeText(getActivity(), errMsg, Toast.LENGTH_LONG).show();
        }
      };
      task.execute(url);
    }
  }
}