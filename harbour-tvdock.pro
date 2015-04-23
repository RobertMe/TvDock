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
    qml/components/Flipable.qml \
    qml/components/MainMenuList.qml \
    qml/components/MainMenuHeader.qml \
    qml/components/PeopleOverview.qml \
    qml/pages/ShowDetails.qml \
    qml/pages/Shows.qml

TRANSLATIONS += \
    translations/harbour-tvdock_en.ts
