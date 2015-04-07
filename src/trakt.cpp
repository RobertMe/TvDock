#include "trakt.h"

#include <QtQuick>
#include "libtraqt/traktconnection.h"

Trakt::Trakt(QObject *parent) :
    QObject(parent)
{
    qmlRegisterUncreatableType<TraktAuthenticator>("harbour.tvdock", 1, 0, "TraktAuthenticator", "Get authenticator from trakt.authenticator");
    qmlRegisterType<TraktMovies>("harbour.tvdock", 1, 0, "TraktMovies");
    qmlRegisterUncreatableType<TraktMoviesModel>("harbour.tvdock", 1, 0, "TraktMoviesModel", "Get movies using TraktMovies");
    qmlRegisterType<TraktImages>("harbour.tvdock", 1, 0, "TraktImages");
}

TraktAuthenticator* Trakt::authenticator() const
{
    return m_authenticator;
}

void Trakt::setAuthenticator(TraktAuthenticator *authenticator)
{
    m_authenticator = authenticator;
    TraktConnection::instance()->setAuthenticator(authenticator);
    emit authenticatorChanged();
}
