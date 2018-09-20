import Foundation
import RxSwift

class CarListModuleDefaultPresenter<B: ViewModelBuilder>: CarListModulePresenter where B.Model == Car, B.ViewModel == CarListViewModel {
    
    private let disposeBag = DisposeBag()
    
    private unowned let view: CarListModuleView
    private let router: CarListModuleRouter
    private let interactor: CarListModuleInteractor
    
    private let viewModelBuilder: B
    
    init(view: CarListModuleView,
         router: CarListModuleRouter,
         interactor: CarListModuleInteractor,
         viewModelBuilder: B)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.viewModelBuilder = viewModelBuilder
    }
    
    func viewDidLoad() {
        interactor.findCars().subscribe(
            onNext: { [weak self] cars in
                self?.showCars(cars) },
            onError: { error in
                fatalError("Not") }
        ).disposed(by: disposeBag)
    }
    
    func showCars(_ cars: [Car]) {
        let viewModels = cars.map({viewModelBuilder.build($0)})
        view.showCars(viewModels)
    }
}
