import XCTest
@testable import WunderTest

class CarMapViewModelBuilderTestCase: XCTestCase {
    
    var builder: CarMapViewModelBuilder!
    
    override func setUp() {
        builder = CarMapViewModelBuilder()
    }
    
    func test_BuildViewModelFromModel_BuildResultIsSameAsExpected() {
        
        let testingModel = Car(address: "Lesserstraße 170, 22049 Hamburg",
                               coordinates: Coordinates(longitude: 10.07526,
                                                        latitude: 53.59301,
                                                        orientation: 1.23),
                               engineType: "CE",
                               exterior: .good,
                               fuel: 42,
                               interior: .unacceptable,
                               name: "HH-GO8522",
                               vin: "WME4513341K565439")
        
        let expectedViewModel = CarMapViewModel(title: "HH-GO8522",
                                                vin: "WME4513341K565439",
                                                latitude: 53.59301,
                                                longitude: 10.07526,
                                                orientation: 1.23)
        
        let resultViewModel = builder.build(testingModel)
        
        XCTAssertEqual(expectedViewModel.title, resultViewModel.title, "Title")
        XCTAssertEqual(expectedViewModel.vin, resultViewModel.vin, "VIN")
        XCTAssertEqual(expectedViewModel.latitude, resultViewModel.latitude, "Latitude")
        XCTAssertEqual(expectedViewModel.longitude, resultViewModel.longitude, "Longitude")
        XCTAssertEqual(expectedViewModel.orientation, resultViewModel.orientation, "Orientation")
    }
}
