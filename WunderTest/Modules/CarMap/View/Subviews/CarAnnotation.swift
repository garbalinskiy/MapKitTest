import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var vin: String
    var coordinate: CLLocationCoordinate2D
    var orientation: CGFloat
    
    init( title: String, vin: String, coordinate: CLLocationCoordinate2D, orientation: Double) {
        self.vin = vin
        self.title = title
        self.coordinate = coordinate
        self.orientation = CGFloat(orientation)
        super.init()
    }
    
    public static func == (lhs: CarAnnotation, rhs: CarAnnotation) -> Bool {
        return lhs.vin == rhs.vin
    }
}
