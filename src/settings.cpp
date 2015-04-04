#include "settings.h"

Settings::Settings()
{
}

QString Settings::traktRefreshToken()
{
    beginGroup("trakt");
    QString token = value("refreshToken").toString();
    endGroup();
    return token;
}

void Settings::setTraktRefreshToken(const QString &token)
{
    beginGroup("trakt");
    setValue("refreshToken", token);
    endGroup();
}
