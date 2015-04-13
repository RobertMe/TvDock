import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    property alias text: label.text
    property alias font: label.font

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: label.implicitHeight
        interactive: contentHeight > height
        clip: true
        Label {
            id: label
            width: parent.width
            wrapMode: Text.WordWrap
        }
    }

    OpacityRampEffect {
        property int maxFlickY: flickable.contentHeight - flickable.height
        property double flickPercentage: flickable.contentY / maxFlickY
        enabled: flickable.interactive

        direction: OpacityRamp.TopToBottom
        slope: 2
        offset: .5 + (flickPercentage * .5)
        sourceItem: flickable
    }
}
