
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import com.mercadopago.android.px.core.MercadoPagoCheckout;

public class RNMercadoPagoCheckoutV4Module extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private String _publicKey;
  private String _preferenceId;
  private static final int REQUEST_CODE = 1;

  public RNMercadoPagoCheckoutV4Module(ReactApplicationContext reactContext) {
    super(reactContext);
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
  }

  @ReactMethod
  public void open() {
    new MercadoPagoCheckout.Builder(this._publicKey, this._preferenceId).build()
                    .startPayment(this.reactContext, this.REQUEST_CODE);
  }
}