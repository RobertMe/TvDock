import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: cover

    Column {
        width: parent.width
        height: childrenRect.height
        anchors.centerIn: parent

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: "TVDock"
            font.pixelSize: Theme.fontSizeMedium
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: qsTrId("header-authenticating")
            font.pixelSize: Theme.fontSizeSmall
        }
    }
}
