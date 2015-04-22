#include "trakt.h"

#include <QtQuick>
#include "libtraqt/traktconnection.h"
#include "libtraqt/traktpeoplemodel.h"
#include "libtraqt/traktmovies.h"
#include "libtraqt/traktshows.h"
#include "libtraqt/traktseasonsmodel.h"

Trakt::Trakt(QObject *parent) :
    QObject(parent)
{
    qmlRegisterUncreatableType<TraktAuthenticator>("harbour.tvdock", 1, 0, "TraktAuthenticator", "Get authenticator from trakt.authenticator");
    qmlRegisterType<TraktImages>("harbour.tvdock", 1, 0, "TraktImages");
    qmlRegisterUncreatableType<TraktPeopleModel>("harbour.tvdock", 1, 0, "TraktPeopleModel", "Get people using movie/show/...");
    qmlRegisterUncreatableType<TraktPeopleFilterModel>("harbour.tvdock", 1, 0, "TraktPeopleModel", "Use People.{cast/crew} instead");
    qmlRegisterType<TraktMovies>("harbour.tvdock", 1, 0, "TraktMovies");
    qmlRegisterUncreatableType<TraktMoviesModel>("harbour.tvdock", 1, 0, "TraktMoviesModel", "Get movies using TraktMovies");
    qmlRegisterType<TraktMovie>("harbour.tvdock", 1, 0, "TraktMovie");
    qmlRegisterType<TraktShows>("harbour.tvdock", 1, 0, "TraktShows");
    qmlRegisterUncreatableType<TraktShowsModel>("harbour.tvdock", 1, 0, "TraktShowModel", "Get shows using TraktShows");
    qmlRegisterType<TraktShow>("harbour.tvdock", 1, 0, "TraktShow");
    qmlRegisterUncreatableType<TraktSeasonsModel>("harbour.tvdock", 1, 0, "TraktSeasons", "Get seasons using trakt.seasons(show)");
    qmlRegisterType<TraktSeason>("harbour.tvdock", 1, 0, "TraktSeason");
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

TraktSeasonsModel *Trakt::getSeasons(TraktShow *show)
{
    return new TraktSeasonsModel(show);
}
