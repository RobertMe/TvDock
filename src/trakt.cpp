#include "trakt.h"

#include <QtQuick>
#include "libtraqt/traktconnection.h"
#include "libtraqt/traktpeoplemodel.h"
#include "libtraqt/traktmovies.h"
#include "libtraqt/traktshows.h"
#include "libtraqt/traktseasonsmodel.h"
#include "libtraqt/traktcheckin.h"

Trakt::Trakt(QObject *parent) :
    QObject(parent),
    m_movies(new TraktMovies(this)),
    m_shows(new TraktShows(this))
{
    qmlRegisterUncreatableType<TraktIds>("harbour.tvdock", 1, 0, "TraktIds", "Not creatable, but fetchable from item using ids property");
    qmlRegisterUncreatableType<TraktAuthenticator>("harbour.tvdock", 1, 0, "TraktAuthenticator", "Get authenticator from trakt.authenticator");
    qmlRegisterType<TraktImages>("harbour.tvdock", 1, 0, "TraktImages");
    qmlRegisterUncreatableType<TraktPeopleModel>("harbour.tvdock", 1, 0, "TraktPeopleModel", "Get people using movie/show/...");
    qmlRegisterUncreatableType<TraktPeopleFilterModel>("harbour.tvdock", 1, 0, "TraktPeopleModel", "Use People.{cast/crew} instead");
    qmlRegisterUncreatableType<TraktMovies>("harbour.tvdock", 1, 0, "TraktMovies", "Get movies using trakt.movies");
    qmlRegisterUncreatableType<TraktMoviesModel>("harbour.tvdock", 1, 0, "TraktMoviesModel", "Get movies using trakt.movies");
    qmlRegisterType<TraktMovie>("harbour.tvdock", 1, 0, "TraktMovie");
    qmlRegisterUncreatableType<TraktShows>("harbour.tvdock", 1, 0, "TraktShows", "Get shows using trakt.shows");
    qmlRegisterUncreatableType<TraktShowsModel>("harbour.tvdock", 1, 0, "TraktShowModel", "Get shows using trakt.shows");
    qmlRegisterType<TraktShow>("harbour.tvdock", 1, 0, "TraktShow");
    qmlRegisterUncreatableType<TraktSeasonsModel>("harbour.tvdock", 1, 0, "TraktSeasons", "Get seasons using trakt.shows.getSeasons(show)");
    qmlRegisterType<TraktSeason>("harbour.tvdock", 1, 0, "TraktSeason");
    qmlRegisterUncreatableType<TraktCheckin>("harbour.tvdock", 1, 0, "TraktCheckin", "Create checkin using trakt.checkin");
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

TraktMovies *Trakt::movies()
{
    return m_movies;
}

TraktShows *Trakt::shows()
{
    return m_shows;
}

TraktCheckin *Trakt::createCheckin(TraktIds *ids)
{
    if (ids->type() != "movies" && ids->type() != "episodes") {
        return 0;
    }

    TraktCheckin *checkin = new TraktCheckin();
    checkin->setItem(ids);
    checkin->setAppDate(BUILD_DATE);
    checkin->setAppVersion(BUILD_VERSION);
    return checkin;
}
