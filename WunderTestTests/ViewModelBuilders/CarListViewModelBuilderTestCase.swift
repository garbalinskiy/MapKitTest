import XCTest
@testable import WunderTest

class CarListViewModelBuilderTestCase: XCTestCase {
    
    var builder: CarListViewModelBuilder!
    
    override func setUp() {
        builder = CarListViewModelBuilder()
    }

    func test_BuildViewModelFromModel_BuildResultIsSameAsExpected() {
        
        let testingModel = Car(address: "Lesserstraße 170, 22049 Hamburg",
                               coordinates: Coordinates(longitude: 10.07526,
                                                        latitude: 53.59301,
                                                        orientation: 0),
                               engineType: "CE",
                               exterior: .good,
                               fuel: 42,
                               interior: .unacceptable,
                               name: "HH-GO8522",
                               vin: "WME4513341K565439")
        
        let expectedViewModel = CarListViewModel(name: "HH-GO8522",
                                                 vin: "WME4513341K565439",
                                                 address: "Lesserstraße 170, 22049 Hamburg",
                                                 coordinates: "53.59301, 10.07526",
                                                 engineType: "CE",
                                                 fuel: "42",
                                                 exterior: "Good",
                                                 interior: "Unacceptable")
        
        let resultViewModel = builder.build(testingModel)
        
        XCTAssertEqual(expectedViewModel.name, resultViewModel.name, "Name")
        XCTAssertEqual(expectedViewModel.vin, resultViewModel.vin, "VIN")
        XCTAssertEqual(expectedViewModel.address, resultViewModel.address, "Address")
        XCTAssertEqual(expectedViewModel.coordinates, resultViewModel.coordinates, "Coordinates")
        XCTAssertEqual(expectedViewModel.engineType, resultViewModel.engineType, "Engine type")
        XCTAssertEqual(expectedViewModel.fuel, resultViewModel.fuel, "Fuel")
        XCTAssertEqual(expectedViewModel.exterior, resultViewModel.exterior, "Exterior")
        XCTAssertEqual(expectedViewModel.interior, resultViewModel.interior, "Interior")
    }
}
