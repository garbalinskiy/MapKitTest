import XCTest
@testable import WunderTest

class CarListModuleDefaultInteractorTestCase: XCTestCase {

    var carMockRepository: CarMockRepository!
    var interactor: CarListModuleInteractor!
    
    override func setUp() {
        carMockRepository = CarMockRepository()
        interactor = CarListModuleDefaultInteractor(carRepository: carMockRepository)
    }

    func test_FindAllCars_ResultCarsMatchSameAsMockRepositoryHas() {
        
        var resultCars: [Car] = []
        
        let findExpectation = expectation(description: "Find cars")
        let disposable = interactor.findCars().subscribe(onNext: { cars in
            resultCars = cars
            findExpectation.fulfill()
        }, onError: { error in
            assertionFailure(error.localizedDescription)
            findExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.5)
        disposable.dispose()
        
        XCTAssertEqual(resultCars, carMockRepository.findAllCars)
    }

}
