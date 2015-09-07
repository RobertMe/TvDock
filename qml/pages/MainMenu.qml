import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: defaultAllowedOrientations

    function updateCover() {
        if (mainMenu.currentIndex === 0) {
            showCover("ItemList", {items: trendingMovies.sourceModel, title: qsTrId("header-movies") });
        } else if (mainMenu.currentIndex === 1) {
            showCover("ItemList", {items: trendingShows.sourceModel, title: qsTrId("header-shows") });
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Active) {
            updateCover();
        }
    }

    SilicaListView {
        id: mainMenu
        anchors.fill: parent
        clip: true
        quickScrollEnabled: false

        snapMode: ListView.SnapOneItem

        PullDownMenu {
            MenuItem {
                //% "Log in"
                text: qsTrId("login")
                onClicked: pageStack.push("Authenticate.qml")
                enabled: !trakt.authenticator.authorized
                visible: enabled
            }
            MenuItem {
                //% "Search"
                text: qsTrId("search")
                onClicked: pageStack.push("Search.qml")
            }
        }

        onCurrentIndexChanged: page.updateCover()

        onFlickEnded: {
            currentIndex = indexAt(contentX, contentY)
        }

        model: VisualItemModel {
            Column {
                width: mainMenu.width
                height: mainMenu.height

                Item { width: parent.width; height: Theme.paddingLarge }

                MainMenuHeader {
                    id: moviesHeader
                    maxWidth: parent.width
                    //% "Movies"
                    title: qsTrId("header-movies")
                }

                Turnable {
                    id: moviesContainer
                    height: parent.height - y - Theme.paddingLarge
                    width: parent.width
                    columnSpacing: Theme.paddingLarge

                    MainMenuList {
                        id: trendingMovies
                        //% "Trending"
                        title: qsTrId("list-trending")
                        sourceModel: trakt.movies.trending()
                        mode: "trending"
                        pageName: Qt.resolvedUrl("Movies.qml")
                        width: moviesContainer.itemWidth
                        height: moviesContainer.itemHeight
                        delegate: MovieItem {
                            grid: trendingMovies.grid
                        }
                    }

                    MainMenuList {
                        id: popularMovies
                        //% "Popular"
                        title: qsTrId("list-popular")
                        sourceModel: trakt.movies.popular()
                        mode: "popular"
                        pageName: Qt.resolvedUrl("Movies.qml")
                        width: moviesContainer.itemWidth
                        height: moviesContainer.itemHeight
                        delegate: MovieItem {
                            grid: popularMovies.grid
                        }
                    }
                }
            }

            Column {
                width: mainMenu.width
                height: mainMenu.height

                Item { width: parent.width; height: Theme.paddingLarge }

                MainMenuHeader {
                    maxWidth: parent.width
                    //% "TV Shows"
                    title: qsTrId("header-shows")
                }

                Turnable {
                    id: showsContainer
                    height: parent.height - y - Theme.paddingLarge
                    width: parent.width
                    columnSpacing: Theme.paddingLarge

                    MainMenuList {
                        id: trendingShows
                        //% "Trending"
                        title: qsTrId("list-trending")
                        sourceModel: trakt.shows.trending()
                        mode: "trending"
                        pageName: Qt.resolvedUrl("Shows.qml")
                        width: showsContainer.itemWidth
                        height: showsContainer.itemHeight
                        delegate: ShowItem {
                            grid: trendingShows.grid
                        }
                    }

                    MainMenuList {
                        id: popularShows
                        //% "Popular"
                        title: qsTrId("list-popular")
                        sourceModel: trakt.shows.popular()
                        mode: "popular"
                        pageName: Qt.resolvedUrl("Shows.qml")
                        width: showsContainer.itemWidth
                        height: showsContainer.itemHeight
                        delegate: ShowItem {
                            grid: popularShows.grid
                        }
                    }
                }
            }
        }
    }
}
