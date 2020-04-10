
import { NativeModules, NativeEventEmitter} from 'react-native';

const { RNMercadoPagoCheckoutV4 } = NativeModules;
const events = new NativeEventEmitter(RNMercadoPagoCheckoutV4);
//export default RNMercadoPagoCheckoutV4;

export default {
    setPublicKey: publicKey => RNMercadoPagoCheckoutV4.setPublicKey(publicKey),
    setPreferenceId: preferenceId => RNMercadoPagoCheckoutV4.setPreferenceId(preferenceId),
    open: () => RNMercadoPagoCheckoutV4.open(),
    addListener: func => events.addListener("checkout", func),
    remove: () => events.remove(),
}
