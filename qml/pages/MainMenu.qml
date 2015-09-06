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

                    Column {
                        width: moviesContainer.itemWidth
                        height: moviesContainer.itemHeight

                        SectionHeader {
                            height: implicitHeight + Theme.paddingSmall * 2
                            //% "Trending"
                            text: qsTrId("list-trending")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: pageStack.push("Movies.qml", {model: trendingMovies.sourceModel, mode: "trending"})
                            }
                        }

                        MainMenuList {
                            id: trendingMovies
                            height: parent.height - y
                            sourceModel: trakt.movies.trending()
                            delegate: MovieItem {
                                grid: trendingMovies
                            }

                            onShowAll: pageStack.push("Movies.qml", {model: sourceModel, mode: "trending"})
                        }
                    }

                    Column {
                        width: moviesContainer.itemWidth
                        height: moviesContainer.itemHeight

                        SectionHeader {
                            height: implicitHeight + Theme.paddingSmall * 2
                            //% "Popular"
                            text: qsTrId("list-popular")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: pageStack.push("Movies.qml", {model: popularMovies.sourceModel, mode: "popular"})
                            }
                        }

                        MainMenuList {
                            id: popularMovies
                            height: parent.height - y
                            sourceModel: trakt.movies.popular()
                            delegate: MovieItem {
                                grid: popularMovies
                            }

                            onShowAll: pageStack.push("Movies.qml", {model: sourceModel, mode: "popular"})
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

                    Column {
                        width: showsContainer.itemWidth
                        height: showsContainer.itemHeight

                        SectionHeader {
                            height: implicitHeight + Theme.paddingSmall * 2
                            //% "Trending"
                            text: qsTrId("list-trending")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: pageStack.push("Shows.qml", {model: trendingShows.sourceModel, mode: "trending"})
                            }
                        }

                        MainMenuList {
                            id: trendingShows
                            height: parent.height - y
                            sourceModel: trakt.shows.trending()
                            delegate: ShowItem {
                                grid: trendingShows
                            }

                            onShowAll: pageStack.push("Shows.qml", {model: sourceModel, mode: "trending"})
                        }
                    }

                    Column {
                        width: showsContainer.itemWidth
                        height: showsContainer.itemHeight

                        SectionHeader {
                            height: implicitHeight + Theme.paddingSmall * 2
                            //% "Popular"
                            text: qsTrId("list-popular")

                            MouseArea {
                                anchors.fill: parent
                                onClicked: pageStack.push("Shows.qml", {model: popularShows.sourceModel, mode: "popular"})
                            }
                        }

                        MainMenuList {
                            id: popularShows
                            height: parent.height - y
                            sourceModel: trakt.shows.popular()
                            delegate: ShowItem {
                                grid: popularShows
                            }
                            onShowAll: pageStack.push("Shows.qml", {model: sourceModel, mode: "popular"})
                        }
                    }
                }
            }
        }
    }
}
