#ifndef IMAGECACHE_H
#define IMAGECACHE_H

#include <QObject>
#include <QHash>
#include <QNetworkAccessManager>
#include <QPointer>
#include <QUrl>

class ImageFetchJob;

class ImageCache : public QObject
{
    Q_OBJECT
public:

    explicit ImageCache(QObject *parent = 0);
    static ImageCache *instance();

    void fetch(QUrl source, QObject *receiver, const char *method);
private:

    static ImageCache *s_instance;

    QString m_cacheDir;
    QHash<QUrl, QUrl> m_availableImages;
    QNetworkAccessManager m_nam;
    QHash<QUrl, ImageFetchJob*> m_runningJobs;

private slots:
    void imageDownloaded();
};

class ImageFetchJob : public QObject {
    Q_OBJECT
public:
    explicit ImageFetchJob(const QUrl &source, const QUrl &cacheFile, QObject *parent) : QObject(parent), cacheFile(cacheFile), source(source) { }

    QUrl cacheFile;
    QList<QPair<QPointer<QObject>, const char *> > callbacks;
    QUrl source;
};

#endif // IMAGECACHE_H
