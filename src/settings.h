#ifndef SETTINGS_H
#define SETTINGS_H

#include <QSettings>

class Settings : public QSettings
{
    Q_OBJECT
public:
    Settings();

    QString traktRefreshToken();

public slots:
    void setTraktRefreshToken(const QString &token);
};

#endif // SETTINGS_H
