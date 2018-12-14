
import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const { RNEuromsg } = NativeModules;

const RNEuromsgEvt = new NativeEventEmitter(RNEuromsg)

console.log("RNEuromsg", RNEuromsg);

export default class Euromsg {
    static addListener(name, listener) {
        RNEuromsgEvt.addListener(name, listener);
    }

    static async getInitialNotification() {
        try {
            if (Platform.OS === 'android') {
                const notif = await RNEuromsg.getInitialNotification();
                console.log("initial android notif", notif);
                return notif;
            } else {
                const notif = await RNEuromsg.getInitialNotification();
                console.log("initial shit", notif);
                return notif;
            }
        } catch (e) {
            console.error(e);
        }
    }

    static setDebug(isDebug) {
        RNEuromsg.setDebug(isDebug);
    }

    static configUser(config) {
        RNEuromsg.configUser(config);
    }
}