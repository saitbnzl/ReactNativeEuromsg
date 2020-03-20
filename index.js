
import { NativeModules, NativeEventEmitter, Platform } from "react-native";

const { RNEuromsg } = NativeModules;

const RNEuromsgEvt = new NativeEventEmitter(RNEuromsg);

console.log("RNEuromsg", RNEuromsg);

export default class Euromsg {
    static addListener(name, listener) {
        RNEuromsgEvt.addListener(name, listener);
    }

    static async getInitialNotification() {
        try {
            if (Platform.OS === "android") {
                const notif = await RNEuromsg.getInitialNotification();
                console.log("initial android notif", notif);
                if (notif ?.pushId)
                    this.reportRead(notif.pushId);
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

    static setBadgeCount(count) {
        RNEuromsg.setBadgeNumber(count);
    }

    static reportRead(pid) {
        RNEuromsg.reportRead(pid);
    }

    static configUser(config) {
        RNEuromsg.configUser(config);
    }

    static setPermit(permit) {
        RNEuromsg.setPermit(permit);
    }

}