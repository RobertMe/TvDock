#include "limitedmodel.h"

LimitedModel::LimitedModel(QObject *parent) :
    QSortFilterProxyModel(parent),
    m_maxItems(0)
{
}

bool LimitedModel::canFetchMore(const QModelIndex &parent) const
{
    return sourceModel() && sourceModel()->rowCount(parent) < m_maxItems && sourceModel()->canFetchMore(parent);
}

bool LimitedModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    Q_UNUSED(source_parent)
    return source_row < m_maxItems;
}

int LimitedModel::maxItems() const
{
    return m_maxItems;
}

void LimitedModel::setMaxItems(int maxItems)
{
    m_maxItems = maxItems;
    emit maxItemsChanged();
    invalidateFilter();
}
