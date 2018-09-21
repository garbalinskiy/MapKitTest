import XCTest
@testable import WunderTest
import MapKit

class MKMapSize: XCTestCase {
    
    private let assertAccuracy = 0.00001

    func test_ConvertFromMapSizeToBoundsCoordinates_ResultMatchsExpectedData() {
        
        let testingMapRect = MKMapRect(x: 154034168.74152392,
                                       y: 92068372.271227688,
                                       width: 2686976.2796202898,
                                       height: 4779235.1426845789)
        
        let expectedBounds = (CLLocationCoordinate2D(latitude: 44.72942643116945, longitude: 26.575918000000001),
                                   CLLocationCoordinate2D(latitude: 49.103976333839867, longitude: 30.179434000000043))
        
        let resultBounds = testingMapRect.boundsCoordinates
        
        XCTAssertEqual(expectedBounds.0.latitude, resultBounds.0.latitude, accuracy: assertAccuracy, "Lower bound latitude is incorrect")
        XCTAssertEqual(expectedBounds.0.longitude, resultBounds.0.longitude, accuracy: assertAccuracy, "Lower bound longitude is incorrect")
        XCTAssertEqual(expectedBounds.1.latitude, resultBounds.1.latitude, accuracy: assertAccuracy, "Upper bound latitude is incorrect")
        XCTAssertEqual(expectedBounds.1.longitude, resultBounds.1.longitude, accuracy: assertAccuracy, "Upper bound longitude is incorrect")
    }
}
