import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import harbour.tvdock 1.0


Page {
    id: page

    SilicaWebView {
        anchors.fill: parent
        url: trakt.authenticator.buildAuthorizeUrl();

        onNavigationRequested: {
            request.action = WebView.AcceptRequest;
            var regexp = /https?:\/\/(?:staging\.)?trakt.tv\/oauth\/authorize\/([a-z0-9]{8,})/;

            var match = request.url.toString().match(regexp);
            if (match) {
                trakt.authenticator.authorize(TraktAuthenticator.GrantAccessCode, match[1]);
                request.action = WebView.IgnoreRequest;
            }
        }
    }

    Connections {
        target: trakt.authenticator
        onAuthorizedChanged: pageStack.pop()
    }
}
