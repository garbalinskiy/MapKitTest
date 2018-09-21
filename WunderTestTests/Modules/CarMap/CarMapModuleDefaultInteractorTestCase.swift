import XCTest
@testable import WunderTest

class CarMapModuleDefaultInteractorTestCase: XCTestCase {
    
    var carMockRepository: CarMockRepository!
    var interactor: CarMapModuleDefaultInteractor!
    
    override func setUp() {
        carMockRepository = CarMockRepository()
        interactor = CarMapModuleDefaultInteractor(carRepository: carMockRepository)
    }
    
    func test_FindAllCars_ResultCarsMatchSameAsMockRepositoryHas() {
        
        var resultCars: [Car] = []
        
        let findExpectation = expectation(description: "Find cars")
        let disposable = interactor
            .findCarsInBounds(minLongitude: 40,
                              minLatitude: 10,
                              maxLongitude: 50,
                              maxLatitude: 15)
            .subscribe(
                onNext: { cars in
                    resultCars = cars
                    findExpectation.fulfill() },
                onError: { error in
                    assertionFailure(error.localizedDescription)
                    findExpectation.fulfill()
            })
        
        waitForExpectations(timeout: 0.5)
        disposable.dispose()
        
        XCTAssertEqual(resultCars, carMockRepository.findInBoundsCars)
    }
}
