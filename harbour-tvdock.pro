TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS += \
    libtraqt \
    src

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/Authenticate.qml \
    rpm/harbour-tvdock.changes.in \
    rpm/harbour-tvdock.spec \
    rpm/harbour-tvdock.yaml \
    translations/*.ts \
    harbour-tvdock.desktop \
    qml/main.qml \
    qml/pages/MainMenu.qml \
    qml/pages/Movies.qml

TRANSLATIONS += \
    translations/harbour-tvdock_en.ts
