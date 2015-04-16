import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: videosContainer.height

        Flipable {
            id: videosContainer
            width: parent.width
            height: moviesColumn.height
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

                PageHeader {
                    width: page.isPortrait ? parent.width : implicitWidth
                    //% "Movies"
                    title: qsTrId("menu-movies")
                }

                SectionHeader {
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
        }
    }
}
