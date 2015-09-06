import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: defaultAllowedOrientations

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("Authenticating", {});
            if (trakt.authenticator.authorized) {
                goToMain();
            }
        }
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        spacing: Theme.paddingLarge

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            //% "Authenticating"
            text: qsTrId("header-authenticating")
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
        }

        BusyIndicator {
            anchors.horizontalCenter: parent.horizontalCenter
            size: BusyIndicatorSize.Large
            running: page.visible
        }
    }

    Connections {
        target: trakt.authenticator
        onAuthorizedChanged: {
            if (trakt.authenticator.authorized) {
                goToMain();
            }
        }
    }
}
