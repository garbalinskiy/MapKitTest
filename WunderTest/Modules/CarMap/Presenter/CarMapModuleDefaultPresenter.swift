import Foundation

class CarMapModuleDefaultPresenter: CarMapModulePresenter {
    
    private unowned let view: CarMapModuleView
    private let router: CarMapModuleRouter
    private let interactor: CarMapModuleInteractor
    
    init(view: CarMapModuleView,
         router: CarMapModuleRouter,
         interactor: CarMapModuleInteractor)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        print("View did load")
    }
}
