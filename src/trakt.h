#ifndef TRAKT_H
#define TRAKT_H

#include <QObject>

#include "libtraqt/traktauthenticator.h"

class TraktShow;
class TraktSeasonsModel;

class Trakt : public QObject
{
    Q_OBJECT
    Q_PROPERTY(TraktAuthenticator *authenticator READ authenticator WRITE setAuthenticator NOTIFY authenticatorChanged)
public:
    explicit Trakt(QObject *parent = 0);

    TraktAuthenticator* authenticator() const;
    void setAuthenticator(TraktAuthenticator *authenticator);

    Q_INVOKABLE TraktSeasonsModel *getSeasons(TraktShow *show);

signals:
    void authenticatorChanged();

private:
    TraktAuthenticator *m_authenticator;
};

#endif // TRAKT_H
