#ifndef TRAKT_H
#define TRAKT_H

#include <QObject>

#include "libtraqt/traktauthenticator.h"

class Trakt : public QObject
{
    Q_OBJECT
    Q_PROPERTY(TraktAuthenticator *authenticator READ authenticator WRITE setAuthenticator)
public:
    explicit Trakt(QObject *parent = 0);

    TraktAuthenticator* authenticator() const;
    void setAuthenticator(TraktAuthenticator *authenticator);

private:
    TraktAuthenticator *m_authenticator;
};

#endif // TRAKT_H
