import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    SilicaWebView {
        anchors.fill: parent
        url: trakt.authenticator.buildAuthorizeUrl();

        onUrlChanged: {
            var regexp = /https?:\/\/trakt.tv\/oauth\/authorize\/([a-z0-9]{64})/;

            var match = url.toString().match(regexp);
            if (match) {
                trakt.authenticator.authorizeCode(match[1]);
            }
        }
    }
}
