package com.example.todo;

import android.Manifest;
import android.annotation.SuppressLint;
import androidx.annotation.NonNull;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.IntentFilter;
import android.provider.Contacts;
import android.provider.ContactsContract;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import android.provider.CallLog;
import android.util.Log;
import android.widget.Toast;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
//import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;



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

                    }else if(call.method.equals("getpermissionscall")){
                       checkPermission(Manifest.permission.READ_CALL_LOG,1001);
                        result.success("a");
                        
                    }else if(call.method.equals("getpermissionscontactsread")){
                        
                      checkPermission(Manifest.permission.READ_CONTACTS,1002);
                     result.success("b");

                    }
                    else if(call.method.equals("getpermissionscontactswrite")){
                        
                         checkPermission(Manifest.permission.WRITE_CONTACTS,1003);
                        result.success("c");
   
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
           Cursor cur = null;
           if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ECLAIR) {
               cur = cr.query(ContactsContract.Contacts.CONTENT_URI,
               null, null, null, null);
           }
           if ((cur != null ? cur.getCount() : 0) > 0) {
               while (cur != null && cur.moveToNext()) {
                  String id = cur.getString(
                  cur.getColumnIndex(ContactsContract.Contacts._ID));
                  String name = cur.getString(cur.getColumnIndex(
                  ContactsContract.Contacts.DISPLAY_NAME));
                  nameList.add(name);
                  if (cur.getInt(cur.getColumnIndex( ContactsContract.Contacts.HAS_PHONE_NUMBER)) > 0) {
                      Cursor pCur = null;
                      if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ECLAIR) {
                          pCur = cr.query(
                          ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                          null,
                          ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = ?",
                          new String[]{id}, null);
                      }
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
            values.put(Contacts.People.NUMBER, phone);
            values.put(Contacts.People.TYPE, ContactsContract.CommonDataKinds.Phone.TYPE_CUSTOM);
            values.put(Contacts.People.LABEL, name);
            values.put(Contacts.People.NAME, name);
            Uri dataUri = getContentResolver().insert(Contacts.People.CONTENT_URI, values);
            Uri updateUri = Uri.withAppendedPath(dataUri, Contacts.People.Phones.CONTENT_DIRECTORY);
            values.clear();
            values.put(Contacts.People.Phones.TYPE, Contacts.People.TYPE_MOBILE);
            values.put(Contacts.People.NUMBER, phone);
            updateUri = getContentResolver().insert(updateUri, values);
          }
    public void checkPermission(String permission, int requestCode)
    {
        if (ContextCompat.checkSelfPermission(MainActivity.this, permission)
                == PackageManager.PERMISSION_DENIED) {

            // Requesting the permission
            ActivityCompat.requestPermissions(MainActivity.this,
                    new String[] { permission },
                    requestCode);
        }
        else {
            // Toast.makeText(this,"Permission Granted Already",Toast.LENGTH_SHORT).show();
           

        }
    }

    @Override
public void onRequestPermissionsResult(int requestCode, String[] permissions,
        int[] grantResults) {
    switch (requestCode) {
        case 1001:

            if (grantResults.length > 0 &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Toast.makeText(this,"Permission granted for call log access ",Toast.LENGTH_SHORT).show();


            }  else {
                Toast.makeText(this,"Permission denied for call log access ",Toast.LENGTH_SHORT).show();

            }
        case 1002:

            if (grantResults.length > 0 &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Toast.makeText(this,"Permission granted for contact read access ",Toast.LENGTH_SHORT).show();


            }  else {
                Toast.makeText(this,"Permission denied for contact read access ",Toast.LENGTH_SHORT).show();

            }
        case 1003:

            if (grantResults.length > 0 &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Toast.makeText(this,"Permission granted for contact write access ",Toast.LENGTH_SHORT).show();


            }  else {
                Toast.makeText(this,"Permission denied for contact write access ",Toast.LENGTH_SHORT).show();

            }
            return;
        }
        
    }



}


