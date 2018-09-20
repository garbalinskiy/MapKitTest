import Foundation

class CarListModuleDefaultPresenter: CarListModulePresenter {
    
    private unowned let view: CarListModuleView
    private let router: CarListModuleRouter
    private let interactor: CarListModuleInteractor
    
    init(view: CarListModuleView,
         router: CarListModuleRouter,
         interactor: CarListModuleInteractor)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        print("View did load")
    }
}
