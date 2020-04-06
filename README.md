
# react-native-mercado-pago-checkout-v4

## Getting started

`$ npm install react-native-mercado-pago-checkout-v4 --save`

### Mostly automatic installation

`$ react-native link react-native-mercado-pago-checkout-v4`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-mercado-pago-checkout-v4` and add `RNMercadoPagoCheckoutV4.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNMercadoPagoCheckoutV4.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

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
RNMercadoPagoCheckoutV4;
```
  