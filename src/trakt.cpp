#include "trakt.h"

#include <QtQuick>
#include "libtraqt/traktconnection.h"
#include "libtraqt/traktmovies.h"
#include "libtraqt/traktmoviesmodel.h"
#include "libtraqt/traktshows.h"
#include "libtraqt/traktshowsmodel.h"
#include "libtraqt/traktseasonsmodel.h"
#include "libtraqt/traktepisodesmodel.h"
#include "libtraqt/traktpeople.h"
#include "libtraqt/traktpeoplemodel.h"
#include "libtraqt/traktcheckin.h"
#include "libtraqt/traktsearchmodel.h"

Trakt::Trakt(QObject *parent) :
    QObject(parent),
    m_movies(new TraktMovies(this)),
    m_shows(new TraktShows(this)),
    m_people(new TraktPeople(this))
{
    qmlRegisterUncreatableType<TraktItem>("harbour.tvdock", 1, 0, "TraktItem", "Use derived types");
    qmlRegisterUncreatableType<TraktIds>("harbour.tvdock", 1, 0, "TraktIds", "Not creatable, but fetchable from item using ids property");
    qmlRegisterUncreatableType<TraktAuthenticator>("harbour.tvdock", 1, 0, "TraktAuthenticator", "Get authenticator from trakt.authenticator");
    qmlRegisterType<TraktImages>("harbour.tvdock", 1, 0, "TraktImages");
    qmlRegisterUncreatableType<TraktPeople>("harbour.tvdock", 1, 0, "TraktPeople", "Get people using trakt.people");
    qmlRegisterUncreatableType<TraktPeopleModel>("harbour.tvdock", 1, 0, "TraktPeopleModel", "Get people using movie/show/...");
    qmlRegisterUncreatableType<TraktPeopleFilterModel>("harbour.tvdock", 1, 0, "TraktPeopleModel", "Use People.{cast/crew} instead");
    qmlRegisterType<TraktPerson>("harbour.tvdock", 1, 0, "TraktPerson");
    qmlRegisterUncreatableType<TraktMovies>("harbour.tvdock", 1, 0, "TraktMovies", "Get movies using trakt.movies");
    qmlRegisterUncreatableType<TraktMoviesModel>("harbour.tvdock", 1, 0, "TraktMoviesModel", "Get movies using trakt.movies");
    qmlRegisterType<TraktMovie>("harbour.tvdock", 1, 0, "TraktMovie");
    qmlRegisterUncreatableType<TraktShows>("harbour.tvdock", 1, 0, "TraktShows", "Get shows using trakt.shows");
    qmlRegisterUncreatableType<TraktShowsModel>("harbour.tvdock", 1, 0, "TraktShowModel", "Get shows using trakt.shows");
    qmlRegisterType<TraktShow>("harbour.tvdock", 1, 0, "TraktShow");
    qmlRegisterUncreatableType<TraktSeasonsModel>("harbour.tvdock", 1, 0, "TraktSeasons", "Get seasons using trakt.shows.getSeasons(show)");
    qmlRegisterType<TraktSeason>("harbour.tvdock", 1, 0, "TraktSeason");
    qmlRegisterUncreatableType<TraktEpisodesModel>("harbour.tvdock", 1, 0, "TraktEpisodesModel", "Get episodes using trakt.shows.getEpisodes(season)");
    qmlRegisterType<TraktEpisode>("harbour.tvdock", 1, 0, "TraktEpisode");
    qmlRegisterUncreatableType<TraktCheckin>("harbour.tvdock", 1, 0, "TraktCheckin", "Create checkin using trakt.checkin");
    qmlRegisterType<TraktSearchModel>("harbour.tvdock", 1, 0, "TraktSearchModel");
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

TraktMovies *Trakt::movies() const
{
    return m_movies;
}

TraktShows *Trakt::shows() const
{
    return m_shows;
}

TraktPeople *Trakt::people() const
{
    return m_people;
}

QString Trakt::imdbBaseUrl() const
{
    return "http://www.imdb.com";
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
