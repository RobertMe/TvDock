#ifndef TRAKT_H
#define TRAKT_H

#include <QObject>

#include "libtraqt/traktauthenticator.h"

class TraktIds;
class TraktMovies;
class TraktShow;
class TraktSeasonsModel;
class TraktShows;
class TraktCheckin;

class Trakt : public QObject
{
    Q_OBJECT
    Q_PROPERTY(TraktAuthenticator *authenticator READ authenticator WRITE setAuthenticator NOTIFY authenticatorChanged)
    Q_PROPERTY(TraktMovies *movies READ movies CONSTANT)
    Q_PROPERTY(TraktShows *shows READ shows CONSTANT)
public:
    explicit Trakt(QObject *parent = 0);

    TraktAuthenticator* authenticator() const;
    void setAuthenticator(TraktAuthenticator *authenticator);

    TraktMovies *movies();
    TraktShows *shows();

    Q_INVOKABLE TraktCheckin *createCheckin(TraktIds *ids);

signals:
    void authenticatorChanged();

private:
    TraktAuthenticator *m_authenticator;
    TraktMovies *m_movies;
    TraktShows *m_shows;
};

#endif // TRAKT_H
