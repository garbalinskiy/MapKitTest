import Foundation
import RxSwift

class CarMapModuleDefaultPresenter<B: ViewModelBuilder>: CarMapModulePresenter where B.Model == Car, B.ViewModel == CarMapViewModel {
    
    private var mapAreaDisposable: Disposable?
    
    private unowned let view: CarMapModuleView
    private let router: CarMapModuleRouter
    private let interactor: CarMapModuleInteractor
    
    private let viewModelBuilder: B
    
    init(view: CarMapModuleView,
         router: CarMapModuleRouter,
         interactor: CarMapModuleInteractor,
         viewModelBuilder: B)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.viewModelBuilder = viewModelBuilder
    }
    
    func viewDidLoad() {
        print("View did load")
    }
    
    func didSelectMapArea(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) {
        mapAreaDisposable = interactor.findCarsInBounds(minLongitude: minLongitude,
                                                        minLatitude: minLatitude,
                                                        maxLongitude: maxLongitude,
                                                        maxLatitude: maxLatitude).subscribe(onNext: { [weak self] cars in
                                                            self?.showCars(cars)
                                                        })
    }
    
    func showCars(_ cars: [Car]) {
        let viewModels = cars.map({ viewModelBuilder.build($0) })
        view.showCars(viewModels)
    }
}
