package com.bnzl.RNEuromsg;

import java.io.Serializable;

public class EuromsgNotif implements Serializable {
    String title = "";
    String message = "";
    String mediaUrl = "";
    String isBigPicture = "";

    public EuromsgNotif(String title, String message, String mediaUrl, String isBigPicture) {
        this.title = title;
        this.message = message;
        this.mediaUrl = mediaUrl;
        this.isBigPicture = isBigPicture;
    }
}
