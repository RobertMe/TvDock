#include "trakt.h"

#include <QtQuick>

Trakt::Trakt(QObject *parent) :
    QObject(parent)
{
    qmlRegisterUncreatableType<TraktAuthenticator>("harbour.tvdock", 1, 0, "TraktAuthenticator", "Get authenticator from trakt.authenticator");
}

TraktAuthenticator* Trakt::authenticator() const
{
    return m_authenticator;
}

void Trakt::setAuthenticator(TraktAuthenticator *authenticator)
{
    m_authenticator = authenticator;
}
