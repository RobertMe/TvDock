TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS += \
    libtraqt \
    src

OTHER_FILES += qml/harbour-tvdock.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-tvdock.changes.in \
    rpm/harbour-tvdock.spec \
    rpm/harbour-tvdock.yaml \
    translations/*.ts \
    harbour-tvdock.desktop
