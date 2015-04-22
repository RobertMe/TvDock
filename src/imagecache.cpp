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
        s_instance->start();
    }

    return s_instance;
}

ImageCache::ImageCache(QObject *parent) :
    QThread(parent)
{
    moveToThread(this);
    m_nam.moveToThread(this);
    m_cacheDir = QStandardPaths::writableLocation(QStandardPaths::CacheLocation) + "/images/";
}

void ImageCache::fetch(const QUrl &source, QObject *receiver, const char *method)
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

    QMetaObject::invokeMethod(this, "internalFetch", Q_ARG(const QUrl, source), Q_ARG(const QUrl, cacheFile), Q_ARG(QObject*, receiver), Q_ARG(const QString, QString(method)));
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
        QPair<QPointer<QObject>, QString> callback = job->callbacks.at(i);
        QMetaObject::invokeMethod(callback.first, callback.second.toLocal8Bit(), Q_ARG(const QUrl&, job->cacheFile));
    }
}

void ImageCache::internalFetch(const QUrl source, const QUrl cacheFile, QObject *receiver, const QString method)
{
    if (!m_runningJobs.contains(source)) {
        ImageFetchJob *job = new ImageFetchJob(source, cacheFile, this);
        m_runningJobs[source] = job;
        QNetworkRequest request;
        request.setUrl(source);
        request.setOriginatingObject(job);
        QNetworkReply *reply = m_nam.get(request);
        connect(reply, &QNetworkReply::finished, this, &ImageCache::imageDownloaded);
    }

    m_runningJobs[source]->callbacks.append(QPair<QPointer<QObject>, QString>(receiver, method));
}
