# NO USAR!! ACTUALMENTE EN DESAROLLO!!!

# DO NOT USE!! CURRENTLY IN DEVELOPMENT!!!

# react-native-mercado-pago-checkout-v4

### React version: 0.61.5

## Getting started

`$ npm install react-native-mercado-pago-checkout-v4-test --save`

### Or

`$ yarn add react-native-mercado-pago-checkout-v4-test`

### Config


#### iOS

Add this line in ios/Podfile before "target <PROJECT_NAME> do":

```objective c
use_frameworks!
```

Remplace this line in AppDelegate.m:

```objective c
self.window.rootViewController = rootViewController;
```

For this:

```objective c
UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
  
[navController setToolbarHidden:YES animated:YES];
[navController setNavigationBarHidden:YES];

self.window.rootViewController = navController;
```

#### Android (NOT WORK YET!)

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNMercadoPagoCheckoutV4Package;` to the imports at the top of the file
  - Add `new RNMercadoPagoCheckoutV4Package()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-mercado-pago-checkout-v4'
  	project(':react-native-mercado-pago-checkout-v4').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-mercado-pago-checkout-v4/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-mercado-pago-checkout-v4')
  	```


## Usage
```javascript
import RNMercadoPagoCheckoutV4 from 'react-native-mercado-pago-checkout-v4';

// TODO: What to do with the module?
RNMercadoPagoCheckoutV4.setPublicKey("public_key");
RNMercadoPagoCheckoutV4.setPreferenceId("preference_id");
RNMercadoPagoCheckoutV4.open();
```
  
