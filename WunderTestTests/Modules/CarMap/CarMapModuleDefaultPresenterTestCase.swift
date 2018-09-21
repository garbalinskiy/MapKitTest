import XCTest
@testable import WunderTest

class CarMapModuleDefaultPresenterTestCase: XCTestCase {

    var mockView: CarMapModuleMockView!
    var mockRouter: CarMapModuleMockRouter!
    var mockInteractor: CarMapModuleMockInteractor!
    var viewModelBuilder: CarMapViewModelBuilder!
    
    var presenter: CarMapModuleDefaultPresenter<CarMapViewModelBuilder>!
    
    override func setUp() {
        mockView = CarMapModuleMockView()
        mockRouter = CarMapModuleMockRouter()
        mockInteractor = CarMapModuleMockInteractor()
        viewModelBuilder = CarMapViewModelBuilder()
        presenter = CarMapModuleDefaultPresenter(view: mockView,
                                                  router: mockRouter,
                                                  interactor: mockInteractor,
                                                  viewModelBuilder: viewModelBuilder)
    }
    
    func test_ViewDidLoad_PresenterGotAllCarsFromInteractorAndPresenterInView() {
        
        let expectedShownCars = mockInteractor.carsInBounds.map({ self.viewModelBuilder.build($0) })
        
        XCTAssertEqual(mockView.shownCars.count, 0, "Invalid intial state of mock view")
        
        presenter.didSelectMapArea(minLongitude: 40, minLatitude: 10, maxLongitude: 50, maxLatitude: 15)
        
        XCTAssertEqual(mockView.shownCars, expectedShownCars, "Cars collection mismatch")
    }

}
