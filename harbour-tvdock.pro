TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS += \
    libtraqt \
    src

OTHER_FILES += \
    rpm/harbour-tvdock.changes.in \
    rpm/harbour-tvdock.spec \
    rpm/harbour-tvdock.yaml \
    translations/*.ts \
    harbour-tvdock.desktop \
    qml/cover/CoverPage.qml \
    qml/pages/Authenticate.qml \
    qml/main.qml \
    qml/pages/MainMenu.qml \
    qml/pages/Movies.qml \
    qml/pages/MovieDetails.qml \
    qml/components/FlickableLabel.qml \
    qml/components/Turnable.qml \
    qml/components/MainMenuList.qml \
    qml/components/MainMenuHeader.qml \
    qml/components/PeopleOverview.qml \
    qml/pages/ShowDetails.qml \
    qml/pages/Shows.qml \
    qml/components/DetailsFlickable.qml \
    qml/components/DetailsFlickablePage.qml \
    qml/components/ItemDetails.qml \
    qml/pages/SeasonDetails.qml \
    qml/pages/EpisodeDetails.qml \
    qml/Utils.js \
    qml/components/DetailsPage.qml \
    qml/pages/PersonDetails.qml \
    qml/components/MovieItem.qml \
    qml/components/ShowItem.qml \

TRANSLATIONS += \
    translations/harbour-tvdock_en.ts
