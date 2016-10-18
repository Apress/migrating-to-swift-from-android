package com.pdachoice.rentalroi;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

//import com.google.analytics.tracking.android.EasyTracker;
//import com.google.analytics.tracking.android.Fields;
//import com.google.analytics.tracking.android.MapBuilder;

public class EditTextViewFragment extends Fragment {
	
  // inner interface
  interface EditTextViewControllerDelegate {
    public void onTextEditSaved(int tag, String text);
    public void onTextEditCanceled();
  }
	
	private int editTextTag;
  private String header;
	private String text;
  private EditTextViewControllerDelegate delegate;
  
  private View contentView;
  private EditText mEditText;

  @Override
  public View onCreateView(LayoutInflater inflater, ViewGroup container,
      Bundle savedInstanceState) {
    contentView = inflater.inflate(R.layout.edittextview_fragment, container, false);
    setHasOptionsMenu(true); // enable Option Menu.

    mEditText = (EditText) contentView.findViewById(R.id.tfEditText);
    this.mEditText.setText(this.text);
    
    return contentView;
  }

  @Override
  public void onResume() {
    super.onResume();
    ((MainActivity) getActivity()).slideIn(contentView, MainActivity.SLIDE_UP); // or SLIDE_LEFT
    showKeyboard();
    getActivity().setTitle(header);
    
//    EasyTracker tracker = EasyTracker.getInstance(getActivity());
//    tracker.set(Fields.SCREEN_NAME, this.getClass().getSimpleName());
//    tracker.send(MapBuilder.createAppView().build());
  }
  
  @Override
  public void onPause() {
    super.onPause();
    hideKeyboard();
  }

  @Override
  public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
    super.onCreateOptionsMenu(menu, inflater);
    inflater.inflate(R.menu.edittextview_menu, menu);
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    String returnText = this.mEditText.getText().toString();
    if(delegate != null) {
      this.delegate.onTextEditSaved(this.getEditTextTag(), returnText);
    }
    return true;
  }

  private void showKeyboard() {
    InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
    imm.showSoftInput(mEditText, InputMethodManager.SHOW_IMPLICIT);    
    mEditText.selectAll();
  }

  private void hideKeyboard() {
    InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
    imm.hideSoftInputFromWindow(mEditText.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
  }

  // public accessors
  public int getEditTextTag() {
    return editTextTag;
  }

  public void setEditTextTag(int editTextTag) {
    this.editTextTag = editTextTag;
  }

  public String getHeader() {
    return header;
  }

  public void setHeader(String header) {
    this.header = header;
  }

  public String getText() {
    return text;
  }

  public void setText(String text) {
    this.text = text;
  }

  public EditTextViewControllerDelegate getDelegate() {
    return delegate;
  }

  public void setDelegate(EditTextViewControllerDelegate delegate) {
    this.delegate = delegate;
  }
  
}