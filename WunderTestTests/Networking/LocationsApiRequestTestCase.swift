import XCTest
@testable import WunderTest

class LocationsApiRequestTestCase: XCTestCase, Stubable {
    
    let stubName = "locations"
    
    lazy var apiService: AlamofireApiService = {
        return AlamofireApiService(config: DefaultConfigService())
    }()
    
    override func setUp() {
        enableStub()
    }
    
    func test_SendRequest_SuccessfullyGotThreeRecordsInResponse() {
        
        let request = LocationsApiRequest()
        var cars: [Car] = []
        let expectedNumberOfCars = 3
        
        let requestExpectation = expectation(description: "Send Request Expectation")
        
        let disposable = apiService.send(request).subscribe(
            onSuccess: { apiResponseCars in
                cars = apiResponseCars.placemarks
                requestExpectation.fulfill() },
            onError: { error in
                assertionFailure(error.localizedDescription)
                requestExpectation.fulfill() }
        )
        
        waitForExpectations(timeout: 1)
        disposable.dispose()
        
        XCTAssertEqual(cars.count, expectedNumberOfCars, "Number of cars in response doesn't match excpected number of cars")
    }
    
}
