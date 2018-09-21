import XCTest
@testable import WunderTest

class CarListModuleDefaultPresenterTestCase: XCTestCase {
    
    var mockView: CarListModuleMockView!
    var mockRouter: CarListModuleMockRouter!
    var mockInteractor: CarListModuleMockInteractor!
    var viewModelBuilder: CarListViewModelBuilder!
    
    var presenter: CarListModuleDefaultPresenter<CarListViewModelBuilder>!
    
    override func setUp() {
        mockView = CarListModuleMockView()
        mockRouter = CarListModuleMockRouter()
        mockInteractor = CarListModuleMockInteractor()
        viewModelBuilder = CarListViewModelBuilder()
        presenter = CarListModuleDefaultPresenter(view: mockView,
                                                  router: mockRouter,
                                                  interactor: mockInteractor,
                                                  viewModelBuilder: viewModelBuilder)
    }
    
    func test_ViewDidLoad_PresenterGotAllCarsFromInteractorAndPresenterInView() {
        
        let expectedShownCars = mockInteractor.findCarsResult.map({ self.viewModelBuilder.build($0) })
        
        XCTAssertEqual(mockView.shownCars.count, 0, "Invalid intial state of mock view")
        
        presenter.viewDidLoad()
        
        XCTAssertEqual(mockView.shownCars, expectedShownCars, "Cars collection mismatch")
    }
}
