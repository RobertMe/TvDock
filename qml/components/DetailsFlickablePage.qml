import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Utils.js" as Utils

Item {
    id: root
    property Item _view: Utils.findDetailsFlickable(root)

    height: _view ? _view.cellHeight : 0
    width: _view ? _view.cellWidth : 0
}
