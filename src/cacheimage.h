#ifndef CACHEIMAGE_H
#define CACHEIMAGE_H

#include <QQuickItem>
#include <QNetworkAccessManager>

#include "imagecache.h"

class CacheImage : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit CacheImage(QQuickItem *parent = 0);

    QUrl source() const;
    void setSource(const QUrl &url);

signals:
    void sourceChanged(const QUrl &source);

private:
    static QNetworkAccessManager s_nam;

    QUrl m_source;
    ImageCache *m_cache;

    void updateSource();

private slots:
    void imageFetched(const QUrl source, const QUrl cacheFile);
};

#endif // CACHEIMAGE_H
