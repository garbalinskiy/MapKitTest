import XCTest
@testable import WunderTest

class CarEntityMapperTestCase: XCTestCase {
    
    private var mapper: CarEntityMapper!

    override func setUp() {
        mapper = CarEntityMapper()
    }

    func test_mapFromModelToEntity_ValuesWhereMappedProperly() {
        
        let sourceModel = Car(address: "Lesserstraße 170, 22049 Hamburg",
                                 coordinates: Coordinates(longitude: 10.07526,
                                                          latitude: 53.59301,
                                                          orientation: 0),
                                 engineType: "CE",
                                 exterior: .good,
                                 fuel: 42,
                                 interior: .unacceptable,
                                 name: "HH-GO8522",
                                 vin: "WME4513341K565439")
        
        let resultEntity = mapper.map(from: sourceModel)
        
        XCTAssertEqual(sourceModel.address, resultEntity.address, "Address")
        XCTAssertEqual(sourceModel.coordinates.longitude, resultEntity.longitude, "Coordinates Longitude")
        XCTAssertEqual(sourceModel.coordinates.latitude, resultEntity.latitude, "Coordinates latitude")
        XCTAssertEqual(sourceModel.coordinates.orientation, resultEntity.orientation, "Coordinates orientation")
        XCTAssertEqual(sourceModel.engineType, resultEntity.engineType, "Engine type")
        XCTAssertEqual(sourceModel.exterior.rawValue, resultEntity.exterior, "Exterior")
        XCTAssertEqual(sourceModel.fuel, resultEntity.fuel, "Fuel")
        XCTAssertEqual(sourceModel.interior.rawValue, resultEntity.interior, "Interior")
        XCTAssertEqual(sourceModel.name, resultEntity.name, "Name")
        XCTAssertEqual(sourceModel.vin, resultEntity.vin, "VIN")
    }
    
    func test_mapFromEntityToModel_ValuesWhereMappedProperly() {
        
        let sourceEntity = CarEntity()
        sourceEntity.address = "Lesserstraße 170, 22049 Hamburg"
        sourceEntity.longitude = 10.07526
        sourceEntity.latitude = 53.59301
        sourceEntity.orientation = 0
        sourceEntity.engineType = "CE"
        sourceEntity.exterior = Condition.good.rawValue
        sourceEntity.fuel = 42
        sourceEntity.interior = Condition.unacceptable.rawValue
        sourceEntity.name = "HH-GO8522"
        sourceEntity.vin = "WME4513341K565439"
        
        let resultModel = mapper.map(from: sourceEntity)
        
        XCTAssertEqual(sourceEntity.address, resultModel.address, "Address")
        XCTAssertEqual(sourceEntity.longitude, resultModel.coordinates.longitude, "Coordinates Longitude")
        XCTAssertEqual(sourceEntity.latitude, resultModel.coordinates.latitude, "Coordinates latitude")
        XCTAssertEqual(sourceEntity.orientation, resultModel.coordinates.orientation, "Coordinates orientation")
        XCTAssertEqual(sourceEntity.engineType, resultModel.engineType, "Engine type")
        XCTAssertEqual(sourceEntity.exterior, resultModel.exterior.rawValue, "Exterior")
        XCTAssertEqual(sourceEntity.fuel, resultModel.fuel, "Fuel")
        XCTAssertEqual(sourceEntity.interior, resultModel.interior.rawValue, "Interior")
        XCTAssertEqual(sourceEntity.name, resultModel.name, "Name")
        XCTAssertEqual(sourceEntity.vin, resultModel.vin, "VIN")
    }

}
