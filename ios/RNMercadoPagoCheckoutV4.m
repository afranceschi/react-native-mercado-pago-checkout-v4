//
//  MercadoPagoBridge.m
//  LightApp
//
//  Created by Agustin Franceschi on 03/04/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//
#import "RNMercadoPagoCheckoutV4.h"
//#import "AppDelegate.h"

@import MercadoPagoSDK;

@interface RNMercadoPagoCheckoutV4 : RCTEventEmitter <RCTBridgeModule,PXLifeCycleProtocol>

@end

@implementation RNMercadoPagoCheckoutV4
{
    UINavigationController *_nav;
    
    BOOL _hasListeners;
    BOOL _navigationBarHidden;
    
    NSString* _publicKey;
    NSString* _preferenceId;
}

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"checkout"];
}

- (void)startObserving
{
  _hasListeners = YES;
}

- (void)stopObserving
{
  _hasListeners = NO;
}

RCT_EXPORT_METHOD(setPublicKey: (NSString *)publicKey){
    _publicKey = publicKey;
}

RCT_EXPORT_METHOD(setPreferenceId: (NSString *)preferenceId){
    _preferenceId = preferenceId;
}

RCT_EXPORT_METHOD(open: (RCTPromiseResolveBlock)resolve
rejecter:(RCTPromiseRejectBlock)reject){
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    
    //AppDelegate *share = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //self->_nav = (UINavigationController *) share.window.rootViewController;
      
    self->_nav = (UINavigationController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    
      MercadoPagoCheckoutBuilder *MPCB = [[MercadoPagoCheckoutBuilder alloc] initWithPublicKey: self->_publicKey preferenceId: self->_preferenceId];
    
    MercadoPagoCheckout *MPC = [[MercadoPagoCheckout alloc] initWithBuilder:MPCB];
     
    self->_navigationBarHidden = self->_nav.navigationBarHidden;
    [self->_nav setNavigationBarHidden:FALSE];
    [self->_nav popToRootViewControllerAnimated:NO];
    
    [MPC startWithNavigationController:self->_nav lifeCycleProtocol: self];
    resolve(@"DATA OK");
    
    printf("OPEN!!!!!!\n");
  });
  
}

- (void (^ _Nullable)(void))cancelCheckout {
    [self->_nav setNavigationBarHidden:self->_navigationBarHidden];
    return ^{
        if (self->_hasListeners) {
          [self sendEventWithName:@"checkout" body:@{ @"status": @"CANCEL" }];
        }
        printf("CANCEL\n");
        [self->_nav popToRootViewControllerAnimated:YES];
    };
}

- (void (^ _Nullable)(id<PXResult> _Nullable))finishCheckout {
  [self->_nav setNavigationBarHidden:self->_navigationBarHidden];
  return ^(id<PXResult>  _Nullable result){
    PXGenericPayment *pago = (PXGenericPayment *) result;
    NSLog(@"PaymentID: %@",pago.paymentId);
    //NSString *paymentid = [NSString stringWithFormat:@"%lld", pago.id];
    if (self->_hasListeners) {
      [self sendEventWithName:@"checkout" body:@{ @"status": @"FINISH", @"paymentId": pago.paymentId}];
    }
    printf("FINISH\n");
    [self->_nav popToRootViewControllerAnimated:YES];
  };
  
  //return nil;
}

@end
