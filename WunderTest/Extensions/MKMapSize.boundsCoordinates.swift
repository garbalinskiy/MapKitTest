import MapKit

extension MKMapRect {
    var boundsCoordinates: (CLLocationCoordinate2D, CLLocationCoordinate2D) {
        return (
            MKMapPoint(x: minX, y: maxY).coordinate,
            MKMapPoint(x: maxX, y: minY).coordinate
        )
    }
}
