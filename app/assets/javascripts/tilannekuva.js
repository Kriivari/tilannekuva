var previousPosition;
var previousZoom;
function savePosition(map) {
    previousPosition = map.getCenter();
    previousZoom = map.getZoom();
}

function returnToSavedPosition(map) {
    if (previousPosition) {
        map.panTo(previousPosition); // or setCenter
        map.setZoom(previousZoom);
    }
}
