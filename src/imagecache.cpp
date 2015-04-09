#include "imagecache.h"

#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QStandardPaths>

ImageCache *ImageCache::s_instance = 0;

ImageCache *ImageCache::instance()
{
    if (!s_instance) {
        s_instance = new ImageCache();
    }

    return s_instance;
}

ImageCache::ImageCache(QObject *parent) :
    QObject(parent)
{
    m_cacheDir = QStandardPaths::writableLocation(QStandardPaths::CacheLocation) + "/images/";
}

void ImageCache::fetch(QUrl source, QObject *receiver, const char *method)
{
    if (m_availableImages.contains(source)) {
        QMetaObject::invokeMethod(receiver, method, Q_ARG(const QUrl&, m_availableImages[source]));
        return;
    }

    QUrl cacheFile;
    cacheFile.setScheme("file");
    cacheFile.setPath(m_cacheDir + source.host() + "/" + source.path());
    if (QFile(cacheFile.path()).exists()) {
        m_availableImages[source] = cacheFile;
        QMetaObject::invokeMethod(receiver, method, Q_ARG(const QUrl&, cacheFile));
        return;
    }

    if (!m_runningJobs.contains(source)) {
        ImageFetchJob *job = new ImageFetchJob(source, cacheFile, this);
        m_runningJobs[source] = job;
        QNetworkRequest request;
        request.setUrl(source);
        request.setOriginatingObject(job);
        QNetworkReply *reply = m_nam.get(request);
        connect(reply, &QNetworkReply::finished, this, &ImageCache::imageDownloaded);
    }

    m_runningJobs[source]->callbacks.append(QPair<QPointer<QObject>, const char *>(receiver, method));
}

void ImageCache::imageDownloaded()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (!reply) {
        return;
    }
    reply->deleteLater();

    ImageFetchJob *job = qobject_cast<ImageFetchJob*>(reply->request().originatingObject());
    if (!job) {
        return;
    }

    job->deleteLater();

    QFileInfo fi(job->cacheFile.path());
    QDir().mkpath(fi.absolutePath());
    QFile file(fi.absoluteFilePath());
    file.open(QIODevice::WriteOnly);
    file.write(reply->readAll());
    file.close();

    for (int i = 0; i < job->callbacks.size(); ++i) {
        QPair<QPointer<QObject>, const char *> callback = job->callbacks.at(i);
        QMetaObject::invokeMethod(callback.first, callback.second, Q_ARG(const QUrl&, job->cacheFile));
    }
}
