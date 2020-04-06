//
//  MercadoPagoBridge.m
//  LightApp
//
//  Created by Agustin Franceschi on 03/04/2020.
//  Copyright © 2020 Facebook. All rights reserved.
//
#import "RNMercadoPagoCheckoutV4.h"
#import "AppDelegate.h"

@import MercadoPagoSDK;

@interface RNMercadoPagoCheckoutV4 : RCTEventEmitter <RCTBridgeModule,PXLifeCycleProtocol>

@end

@implementation RNMercadoPagoCheckoutV4
{
  UINavigationController *_nav;
  BOOL _hasListeners;
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

RCT_EXPORT_METHOD(open: (RCTPromiseResolveBlock)resolve
rejecter:(RCTPromiseRejectBlock)reject){
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    
    AppDelegate *share = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self->_nav = (UINavigationController *) share.window.rootViewController;
    
    MercadoPagoCheckoutBuilder *MPCB = [[MercadoPagoCheckoutBuilder alloc] initWithPublicKey: @"TEST-aeea73ab-d2c2-4e96-93b9-85c0b07e82e4" preferenceId: @"99362128-14e0b380-82da-43be-8e4d-62bd275ef72c"];
    
    MercadoPagoCheckout *MPC = [[MercadoPagoCheckout alloc] initWithBuilder:MPCB];
    
    [self->_nav setNavigationBarHidden:FALSE];
    [self->_nav popToRootViewControllerAnimated:NO];
    
    [MPC startWithNavigationController:self->_nav lifeCycleProtocol: self];
    resolve(@"DATA OK");
    
    printf("OPEN!!!!!!\n");
  });
  
}

- (void (^ _Nullable)(void))cancelCheckout {
    [self->_nav setNavigationBarHidden:TRUE];
    if (_hasListeners) {
      [self sendEventWithName:@"checkout" body:@{ @"status": @"CANCEL" }];
    }
    printf("CANCEL\n");
    return nil;
}

- (void (^ _Nullable)(id<PXResult> _Nullable))finishCheckout {
  [self->_nav setNavigationBarHidden:TRUE];
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
