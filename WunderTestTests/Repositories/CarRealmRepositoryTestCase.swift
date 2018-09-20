import XCTest
@testable import WunderTest
import RealmSwift

class CarRealmRepositoryTestCase: XCTestCase {
    
    lazy var realm: Realm = {
        let config = Realm.Configuration(inMemoryIdentifier: "CarRealmRepositoryTestCase")
        return  try! Realm(configuration: config)
    } ()
    
    lazy var repository: CarRealmRepository = {
        return CarRealmRepository(realm: realm,
                                  entityMapper: CarEntityMapper())
    }()
    
    func test_RealoadDbWithTwoModels_TwoModelsWherePersisted() {
        
        let testingCollection = [
            Car(address: "Lesserstraße 170, 22049 Hamburg",
                coordinates: Coordinates(longitude: 10.07526,
                                         latitude: 53.59301,
                                         orientation: 0),
                engineType: "CE",
                exterior: .good,
                fuel: 42,
                interior: .unacceptable,
                name: "HH-GO8522",
                vin: "WME4513341K565439"),
            Car(address: "Grosse Reichenstraße 7, 20457 Hamburg",
                coordinates: Coordinates(longitude: 9.99622,
                                         latitude: 53.54847,
                                         orientation: 0),
                engineType: "CE",
                exterior: .unacceptable,
                fuel: 45,
                interior: .good,
                name: "HH-GO8480",
                vin: "WME4513341K412697")
            ].sorted(by: { $0.vin > $1.vin })
        
        repository.reload(testingCollection)
        
        let findCarsExpectation = expectation(description: "Find cars subscription")
        
        var actualCollection: [Car] = []
        
        let disposable = repository.findAll().subscribe(onNext: { foundCollection in
            actualCollection = foundCollection.sorted(by: { $0.vin > $1.vin })
            findCarsExpectation.fulfill()
        }, onError: { error in
            assertionFailure(error.localizedDescription)
            findCarsExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1)
        disposable.dispose()
        
        XCTAssertEqual(testingCollection, actualCollection)
    }
    
}
