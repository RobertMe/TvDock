#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>

#include "trakt.h"
#include "oauth-tokens.h"
#include "settings.h"


int main(int argc, char *argv[])
{
    QGuiApplication *application = SailfishApp::application(argc, argv);

    Settings settings;

    Trakt trakt;
    TraktAuthenticator authenticator(TRAKT_CLIENT_ID, TRAKT_CLIENT_SECRET, "urn:ietf:wg:oauth:2.0:oob");
    trakt.setAuthenticator(&authenticator);

    QObject::connect(&authenticator, &TraktAuthenticator::tokensReceived, &settings, &Settings::setTraktRefreshToken);

    authenticator.authorize(TraktAuthenticator::GrantRefreshToken, settings.traktRefreshToken());

    QQuickView *view = SailfishApp::createView();
    view->engine()->rootContext()->setContextProperty("trakt", &trakt);
    view->setSource(SailfishApp::pathTo("qml/main.qml"));

    view->show();

    application->exec();
}
