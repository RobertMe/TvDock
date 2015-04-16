#ifndef LIMITEDMODEL_H
#define LIMITEDMODEL_H

#include <QSortFilterProxyModel>

class LimitedModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(int maxItems READ maxItems WRITE setMaxItems NOTIFY maxItemsChanged)
public:
    explicit LimitedModel(QObject *parent = 0);

    bool canFetchMore(const QModelIndex &parent) const Q_DECL_OVERRIDE;
    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const Q_DECL_OVERRIDE;

    int maxItems() const;
    void setMaxItems(int maxItems);

signals:
    void maxItemsChanged();

private:
    int m_maxItems;
};

#endif // LIMITEDMODEL_H
