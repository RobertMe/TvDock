.pragma library

function findPage(item) {
    var parentItem = item.parent;
    while (parentItem) {
        if (parentItem.hasOwnProperty('__silica_page')) {
            return parentItem;
        }
        parentItem = parentItem.parent;
    }
    return null;
}

function findDetailsFlickable(item) {
    var parentItem = item.parent;
    while (parentItem) {
        if (parentItem.hasOwnProperty('__tvdock_details_flickable')) {
            return parentItem;
        }
        parentItem = parentItem.parent;
    }
    return null;
}
