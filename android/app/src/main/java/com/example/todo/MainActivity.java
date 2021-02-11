package com.example.todo;

import android.annotation.SuppressLint;
import androidx.annotation.NonNull;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.IntentFilter;
import android.provider.ContactsContract;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import android.provider.CallLog;
import android.util.Log;
import android.widget.Toast;

//import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

//import io.flutter.app.FlutterActivity;
// import com.pusher.pushnotifications.PushNotifications;
// import com.pusher.pushnotifications.*;

// import com.pusher.pushnotifications.auth.AuthData;
// import com.pusher.pushnotifications.auth.AuthDataGetter;
// import com.pusher.pushnotifications.auth.BeamsTokenProvider;

public class MainActivity extends FlutterActivity {

    private static final String NotiChannel = "com.example.todos.callLogs";
    MethodChannel m;
    Handler mhandler;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        m =  new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), NotiChannel);
                m.setMethodCallHandler((call, result) -> {
                    if (call.method.equals("getlogs")) {
                        
                       
                        ArrayList<String> logs = getLogs();
                        
                        result.success(logs);
                        
                    }else if(call.method.equals("getcontacts")){
                        ArrayList<String> logs = getAllContacts();
                        
                        result.success(logs);
                    }else if(call.method.equals("addcontact")){
                        final String name = call.argument("name");
                        final String phone = call.argument("phone");
                        addContact(name,phone);

                    }
                    
                });
    }

    private ArrayList<String> getLogs() {
                int flag=1;
                StringBuilder callLogs = new StringBuilder();
        ContentResolver cr = getBaseContext().getContentResolver();
                ArrayList<String> calllogsBuffer = new ArrayList<String>();
                calllogsBuffer.clear();
                Cursor managedCursor = cr.query(CallLog.Calls.CONTENT_URI,
                        null, null, null, null);
                int number = managedCursor.getColumnIndex(CallLog.Calls.NUMBER);
                int type = managedCursor.getColumnIndex(CallLog.Calls.TYPE);
                int date = managedCursor.getColumnIndex(CallLog.Calls.DATE);
                int duration = managedCursor.getColumnIndex(CallLog.Calls.DURATION);
                while (managedCursor.moveToNext()) {
                    String phNumber = managedCursor.getString(number);
                    String callType = managedCursor.getString(type);
                    String callDate = managedCursor.getString(date);
                    Date callDayTime = new Date(Long.valueOf(callDate));
                    String callDuration = managedCursor.getString(duration);
                    String dir = null;
                    int dircode = Integer.parseInt(callType);
                    switch (dircode) {
                        case CallLog.Calls.OUTGOING_TYPE:
                            dir = "OUTGOING";
                            break;
                        case CallLog.Calls.INCOMING_TYPE:
                            dir = "INCOMING";
                            break;
                        case CallLog.Calls.MISSED_TYPE:
                            dir = "MISSED";
                            break;
                    }
                    Log.i("num",phNumber);
                    calllogsBuffer.add("\nPhone Number: " + phNumber + " \nCall Type: "
                            + dir + " \nCall Date: " + callDayTime
                            + " \nCall duration in sec : " + callDuration + "\n");
        
                }
                managedCursor.close();
                return calllogsBuffer;
        }

       private ArrayList getAllContacts() {
            ArrayList<String> nameList = new ArrayList<>();
            ContentResolver cr = getContentResolver();
            Cursor cur = cr.query(ContactsContract.Contacts.CONTENT_URI,
            null, null, null, null);
            if ((cur != null ? cur.getCount() : 0) > 0) {
               while (cur != null && cur.moveToNext()) {
                  String id = cur.getString(
                  cur.getColumnIndex(ContactsContract.Contacts._ID));
                  String name = cur.getString(cur.getColumnIndex(
                  ContactsContract.Contacts.DISPLAY_NAME));
                  nameList.add(name);
                  if (cur.getInt(cur.getColumnIndex( ContactsContract.Contacts.HAS_PHONE_NUMBER)) > 0) {
                     Cursor pCur = cr.query(
                     ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                     null,
                     ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = ?",
                     new String[]{id}, null);
                     while (pCur.moveToNext()) {
                        String phoneNo = pCur.getString(pCur.getColumnIndex(
                        ContactsContract.CommonDataKinds.Phone.NUMBER));
                     }
                     pCur.close();
                  }
               }
            }
            if (cur != null) {
               cur.close();
            }
            return nameList;
         }
         private void addContact(String name, String phone) {
            ContentValues values = new ContentValues();
            values.put(People.NUMBER, phone);
            values.put(People.TYPE, Phone.TYPE_CUSTOM);
            values.put(People.LABEL, name);
            values.put(People.NAME, name);
            Uri dataUri = getContentResolver().insert(People.CONTENT_URI, values);
            Uri updateUri = Uri.withAppendedPath(dataUri, People.Phones.CONTENT_DIRECTORY);
            values.clear();
            values.put(People.Phones.TYPE, People.TYPE_MOBILE);
            values.put(People.NUMBER, phone);
            updateUri = getContentResolver().insert(updateUri, values);
          }


}


