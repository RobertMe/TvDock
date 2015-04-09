#include <QtQuick>

#include <sailfishapp.h>

#include "trakt.h"
#include "oauth-tokens.h"
#include "settings.h"
#include "cacheimage.h"


int main(int argc, char *argv[])
{
    QGuiApplication *application = SailfishApp::application(argc, argv);

    QString language = QLocale::system().name();
    QTranslator qtTranslator;
    if(!qtTranslator.load("qt_" + language, QLibraryInfo::location(QLibraryInfo::TranslationsPath))) {
        qDebug() << "couldn't load qt_" + language;
    }
    application->installTranslator(&qtTranslator);

    QTranslator translator;
    if (!translator.load(":/harbour-tvdock_" + language + ".qm")) {
        qDebug() << "Cannot load translation file" << "harbour-tvdock_" + language + ".qm";

        translator.load(":/harbour-tvdock_en.qm");
    }
    application->installTranslator(&translator);

    Settings settings;

    Trakt trakt;
    TraktAuthenticator authenticator(TRAKT_CLIENT_ID, TRAKT_CLIENT_SECRET, "urn:ietf:wg:oauth:2.0:oob");
    trakt.setAuthenticator(&authenticator);

    QObject::connect(&authenticator, &TraktAuthenticator::tokensReceived, &settings, &Settings::setTraktRefreshToken);

    authenticator.authorize(TraktAuthenticator::GrantRefreshToken, settings.traktRefreshToken());

    qmlRegisterType<CacheImage>("harbour.tvdock", 1, 0, "CacheImage");

    QQuickView *view = SailfishApp::createView();
    view->engine()->rootContext()->setContextProperty("trakt", &trakt);
    view->setSource(SailfishApp::pathTo("qml/main.qml"));

    view->show();

    application->exec();
}
