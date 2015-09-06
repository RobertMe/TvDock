import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: defaultAllowedOrientations
    property Item _optionsPage

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("ItemList", {items: searchGrid.model, title: qsTrId("header-search") + "\n" + searchModel.query });
            if (!_optionsPage) {
                _optionsPage = pageStack.pushAttached("SearchOptions.qml", {type: searchModel.type, year: searchModel.year});
            }

            searchModel.type = _optionsPage.type;
            if (/[12][0-9]{3}/.test(_optionsPage.year)) {
                searchModel.year = parseInt(_optionsPage.year, 10);
            } else {
                searchModel.year = 0;
            }

            searchGrid.headerItem.tryFocusSearchField();
        }
    }

    Connections {
        target: searchModel
        onTypeChanged: _optionsPage.type = searchModel.type
        onYearChanged: _optionsPage.year = searchModel.year
        onQueryChanged: showCover("ItemList", {items: searchGrid.model, title: qsTrId("header-search") + "\n" + searchModel.query });
    }

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        visible: !searchGrid.model.loaded && searchGrid.model.loading
        running: visible
    }

    SilicaGridView {
        id: searchGrid

        property int columnCount: Math.round(parent.width / 150)

        header: Column {
            width: searchGrid.width

            function tryFocusSearchField() {
                if (searchField.text.length === 0) {
                    searchField.forceActiveFocus();
                }
            }

            PageHeader {
                //: Search header
                //% "Search"
                title: qsTrId("header-search");
            }

            SearchField {
                id: searchField
                width: parent.width
                //% "Search"
                placeholderText: qsTrId("placeholder-search")
                text: searchModel.query

                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: searchModel.query = text
            }
        }

        model: TraktSearchModel {
            id: searchModel
        }

        anchors.fill: parent
        cellWidth: parent.width / columnCount
        cellHeight: cellWidth * 1.5

        delegate: ListItem {
            width: searchGrid.cellWidth
            contentHeight: searchGrid.cellHeight

            onClicked: {
                var item = searchModel.at(index);
                switch (item.ids.type) {
                case "movies":
                    return pageStack.push("MovieDetails.qml", {movie: item});
                case "shows":
                    return pageStack.push("ShowDetails.qml", {show: item});
                case "episodes":
                    return pageStack.push("EpisodeDetails.qml", {episode: item});
                case "people":
                    return pageStack.push("PersonDetails.qml", {person: item});
                }
            }

            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit

                CacheImage {
                    source: image.thumb
                }
            }
        }
    }
}
