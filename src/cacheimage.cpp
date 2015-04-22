#include "cacheimage.h"

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QStandardPaths>

QNetworkAccessManager CacheImage::s_nam;

CacheImage::CacheImage(QQuickItem *parent) :
    QQuickItem(parent),
    m_cache(ImageCache::instance())
{
}

QUrl CacheImage::source() const
{
    return m_source;
}

void CacheImage::setSource(const QUrl &url)
{
    if (url == m_source) {
        return;
    }

    m_source = url;
    emit sourceChanged(url);

    updateSource();
}

void CacheImage::updateSource()
{
    m_cache->fetch(m_source, this, "imageFetched");
}

void CacheImage::imageFetched(const QUrl &url)
{
    parentItem()->setProperty("source", url);
}
