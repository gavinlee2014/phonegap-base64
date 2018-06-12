/**
 * 
 * Phonegap Base64 plugin
 * 
 * Version 1.0
 * 
 * Hazem Hagrass 2013
 *
 */

package com.badrit.Base64;

import java.io.File;
import java.io.FileInputStream;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.database.Cursor;
import android.net.Uri;
import android.util.Base64;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;

public class Base64Plugin extends CordovaPlugin {

	@Override
	public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {

        final JSONObject parameters = args.getJSONObject(0);

        if ("encodeFile".equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    try {
                        if (parameters != null) {
                            String base64String = encodeFile(parameters.getString("filePath"));
                            callbackContext.success(base64String);
                        }
                        else {
                            callbackContext.error("filePath is empty");
                        }
                    }
                    catch (Exception e) {
                        callbackContext.error(e.getMessage());
                    }
                }
            });
            return true;
        }

        if ("encodeString".equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    try {
                        if (parameters != null) {
                            String base64String = encodeString(parameters.getString("content"));
                            callbackContext.success(base64String);
                        }
                        else {
                            callbackContext.error("content is empty");
                        }
                    }
                    catch (Exception e) {
                        callbackContext.error(e.getMessage());
                    }
                }
            });

            return true;
        }


		return false; 
	}

	private String encodeString(String content) {
	    return Base64.encodeToString(content.getBytes(), Base64.DEFAULT);
    }

	private String encodeFile(String filePath) {
		String imgStr = "";
		try {
			Uri _uri = Uri.parse(filePath);
			if (_uri != null && "content".equals(_uri.getScheme())) {
				Cursor cursor = cordova
						.getActivity()
						.getContentResolver()
						.query(_uri,
								new String[] { android.provider.MediaStore.Images.ImageColumns.DATA },
								null, null, null);
				cursor.moveToFirst();
				filePath = cursor.getString(0);
				cursor.close();
			} else {
				filePath = _uri.getPath();
			}
			File imageFile = new File(filePath);
			if (!imageFile.exists())
				return imgStr;

			byte[] bytes = new byte[(int) imageFile.length()];

			FileInputStream fileInputStream = new FileInputStream(imageFile);
			fileInputStream.read(bytes);

			imgStr = Base64.encodeToString(bytes, Base64.DEFAULT);
//			imgStr = "data:image/*;charset=utf-8;base64," + imgStr;
		} catch (Exception e) {
			return imgStr;
		}
		return imgStr;		
	}
	

}
