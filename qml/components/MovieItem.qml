import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

ListItem {
    property SilicaGridView grid

    width: grid.cellWidth
    contentHeight: grid.cellHeight

    onClicked: pageStack.push("../pages/MovieDetails.qml", {movie: grid.model.at(index)});

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        CacheImage {
            source: images.poster.thumb
        }
    }
}
