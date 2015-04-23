TARGET = harbour-tvdock

QT += quick qml

SOURCES += main.cpp \
    trakt.cpp \
    settings.cpp \
    cacheimage.cpp \
    imagecache.cpp \
    limitedmodel.cpp

CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
INCLUDEPATH += /usr/include/sailfishapp

target.path = /usr/bin

qml.files = ../qml
qml.path = /usr/share/$${TARGET}

desktop.files = ../$${TARGET}.desktop
desktop.path = /usr/share/applications

icon.files = ../$${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps

INSTALLS += target desktop icon qml

INCLUDEPATH += $${PWD}/../

LIBS += -L../libtraqt -ltraqt

#Needed by qmake to figure that this is a dep.
PRE_TARGETDEPS += ../libtraqt/libtraqt.a

HEADERS += \
    trakt.h \
    oauth-tokens.h \
    oauth-tokens.h \
    settings.h \
    cacheimage.h \
    imagecache.h \
    limitedmodel.h

RESOURCES += ../translations/translations.qrc

OTHER_FILES += \
    ../qml/components/DetailsFlickablePage.qml \
    ../qml/components/Turnable.qml

