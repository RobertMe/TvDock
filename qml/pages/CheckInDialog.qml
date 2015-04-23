import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Dialog {
    id: page
    property QtObject checkin

    DialogHeader {
        id: header
        acceptText: qsTrId("checkin-start")
        anchors.top: parent.top
    }

    onAccepted: checkin.checkIn()

    Turnable {
        id: turnable
        page: page
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            bottomMargin: Theme.paddingLarge
        }

        TextArea {
            width: turnable.itemWidth
            height: turnable.itemHeight
            //: Label and placeholder for "Message" text area during checkin
            //% "Message"
            placeholderText: qsTrId("checkin-message")
            label: qsTrId("checkin-message")
        }

        Column {
            width: turnable.itemWidth
            height: turnable.itemHeight
            TextSwitch {
                automaticCheck: false
                checked: checkin.shareOnFacebook
                onClicked: checkin.shareOnFacebook = !checkin.shareOnFacebook
                //: Label for "Share on Facebook/Twitter/Tumblr" checkbox during check in
                //% "Share on %1"
                text: qsTrId("checkin-share").arg("Facebook")
            }

            TextSwitch {
                automaticCheck: false
                checked: checkin.shareOnTwitter
                onClicked: checkin.shareOnTwitter = !checkin.shareOnTwitter
                text: qsTrId("checkin-share").arg("Twitter")
            }

            TextSwitch {
                automaticCheck: false
                checked: checkin.shareOnTumblr
                onClicked: checkin.shareOnTumblr = !checkin.shareOnTumblr
                text: qsTrId("checkin-share").arg("Tumblr")
            }
        }
    }
}
