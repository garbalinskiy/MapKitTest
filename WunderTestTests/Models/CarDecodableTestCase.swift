import XCTest
@testable import WunderTest

class CarDecodableTestCase: XCTestCase {

    var jsonData: Data!
    
    override func setUp() {
        let jsonURL = Bundle(for: type(of: self)).url(forResource: "location", withExtension: "json")!
        jsonData = try! Data(contentsOf: jsonURL)
    }

    //
    // In this test we compare that every field was correctly decoded from json file
    // Later test can be extened with testing different variations of car JSON objects
    //
    func test_DecodeCarObjectFromData_ResultObjectWasCorrectlyDecoded() {
        
        let expectedObject = Car(address: "Lesserstraße 170, 22049 Hamburg",
                                 coordinates: Coordinates(longitude: 10.07526,
                                                          latitude: 53.59301,
                                                          orientation: 0),
                                 engineType: "CE",
                                 exterior: .good,
                                 fuel: 42,
                                 interior: .unacceptable,
                                 name: "HH-GO8522",
                                 vin: "WME4513341K565439")
        
        do {
            let testingObject = try JSONDecoder().decode(Car.self, from: jsonData)
            
            XCTAssertEqual(expectedObject.address, testingObject.address, "Decode address failed")
            XCTAssertEqual(expectedObject.coordinates, testingObject.coordinates, "Decode coordinates failed")
            XCTAssertEqual(expectedObject.engineType, testingObject.engineType, "Decode engine type failed")
            XCTAssertEqual(expectedObject.address, testingObject.address, "Decode address failed")
            XCTAssertEqual(expectedObject.exterior, testingObject.exterior, "Decode exterior failed")
            XCTAssertEqual(expectedObject.fuel, testingObject.fuel, "Decode fuel failed")
            XCTAssertEqual(expectedObject.interior, testingObject.interior, "Decode interior failed")
            XCTAssertEqual(expectedObject.name, testingObject.name, "Decode name failed")
            XCTAssertEqual(expectedObject.vin, testingObject.vin, "Decode VIN failed")
            
        } catch {
            assertionFailure(error.localizedDescription)
            return
        }
    }

}
