import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        anchors.topMargin: Theme.paddingLarge
        anchors.bottomMargin: Theme.paddingLarge
        contentHeight: videosContainer.height

        Turnable {
            id: videosContainer
            width: parent.width
            height: page.isPortrait ? moviesColumn.height + showsColumn.height : Math.max(moviesColumn.height, showsColumn.height)
            page: page

            Column {
                id: moviesColumn
                width: videosContainer.itemWidth
                height: childrenRect.height

                TraktMovies {
                    id: movies
                }

                Component {
                    id: movieComponent
                    ListItem {
                        width: 150
                        height: width * 1.5

                        Image {
                            width: 150
                            height: width * 1.5
                            fillMode: Image.PreserveAspectFit

                            CacheImage {
                                source: images.poster.thumb
                            }
                        }

                        onClicked: pageStack.push("MovieDetails.qml", {movie: parent.parent.sourceModel.at(index)});
                    }
                }

                MainMenuHeader {
                    maxWidth: parent.width
                    height: Theme.itemSizeExtraSmall
                    //% "Movies"
                    title: qsTrId("menu-movies")
                }

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
                    width: parent.width
                    height: 225
                    sourceModel: movies.trending()
                    delegate: movieComponent
                    onShowAll: pageStack.push("Movies.qml", {model: sourceModel, mode: "trending"})
                }

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
                    width: parent.width
                    height: 225
                    sourceModel: movies.popular()
                    delegate: movieComponent
                    onShowAll: pageStack.push("Movies.qml", {model: sourceModel, mode: "popular"})
                }
            }

            Column {
                id: showsColumn
                width: videosContainer.itemWidth
                height: childrenRect.height

                TraktShows {
                    id: shows
                }

                Component {
                    id: showComponent
                    ListItem {
                        width: 150
                        height: width * 1.5

                        Image {
                            width: 150
                            height: width * 1.5
                            fillMode: Image.PreserveAspectFit

                            CacheImage {
                                source: images.poster.thumb
                            }
                        }

                        onClicked: pageStack.push("ShowDetails.qml", {show: parent.parent.sourceModel.at(index)});
                    }
                }

                MainMenuHeader {
                    maxWidth: parent.width
                    height: Theme.itemSizeExtraSmall
                    //% "TV Shows"
                    title: qsTrId("menu-shows")
                }

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
                    width: parent.width
                    height: 225
                    sourceModel: shows.trending()
                    delegate: showComponent
                    onShowAll: pageStack.push("Shows.qml", {model: sourceModel, mode: "trending"})
                }

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
                    width: parent.width
                    height: 225
                    sourceModel: shows.popular()
                    delegate: showComponent
                    onShowAll: pageStack.push("Shows.qml", {model: sourceModel, mode: "popular"})
                }
            }
        }
    }
}
