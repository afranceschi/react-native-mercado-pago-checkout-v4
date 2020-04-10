
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.mercadopago.android.px.core.MercadoPagoCheckout;
import com.mercadopago.android.px.model.Payment;
import com.mercadopago.android.px.model.exceptions.MercadoPagoError;

public class RNMercadoPagoCheckoutV4Module extends ReactContextBaseJavaModule implements ActivityEventListener{

  private final ReactApplicationContext reactContext;
  private String _publicKey;
  private String _preferenceId;
  private static final int REQUEST_CODE = 1;

  public RNMercadoPagoCheckoutV4Module(ReactApplicationContext reactContext) {
    super(reactContext);
    
    reactContext.addActivityEventListener(this);
    this.reactContext = reactContext;
    this._publicKey = "null";
    this._preferenceId = "null";
  }

  @Override
  public String getName() {
    return "RNMercadoPagoCheckoutV4";
  }

  @ReactMethod
  public void setPublicKey(String publicKey) {
    this._publicKey = publicKey;
  }

  @ReactMethod
  public void setPreferenceId(String preferenceId) {
    this._preferenceId = preferenceId;
    Log.i("STATUS","PREFERENCEID");
  }

  @ReactMethod
  public void open() {
    Activity activity = getCurrentActivity();
    new MercadoPagoCheckout.Builder(this._publicKey, this._preferenceId).build()
                    .startPayment(activity, this.REQUEST_CODE);
  }


  @Override
  public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
      if(requestCode == this.REQUEST_CODE){
        Log.i("STATUS",Integer.toString(resultCode));
        if (resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE) {
          final Payment payment = (Payment) data.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT);
          WritableMap send_data = Arguments.createMap();
          send_data.putString("status", "FINISH");
          send_data.putString("paymentId", Long.toString(payment.getId())); 
          this.reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("checkout", send_data);
          Log.i("STATUS", "Resultado del pago: " + payment.getPaymentStatus());
            //Done!
        } else if (resultCode == 0) {
            if (data != null && data.getExtras() != null
                && data.getExtras().containsKey(MercadoPagoCheckout.EXTRA_ERROR)) {
                final MercadoPagoError mercadoPagoError =
                    (MercadoPagoError) data.getSerializableExtra(MercadoPagoCheckout.EXTRA_ERROR);
                Log.i("STATUS","Error: " +  mercadoPagoError.getMessage());
                //Resolve error in checkout
            } else {
              //Resolve canceled checkout
              WritableMap send_data = Arguments.createMap();
              send_data.putString("status", "CANCEL");
              this.reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit("checkout", send_data);
              Log.i("STATUS","CANCELED");
            }
        }
      }
      // Do nothing
  }

  @Override
  public void onNewIntent(Intent intent) {
    Log.i("STATUS","INTENT");
      //sendJSEvent(intent);
  }
}