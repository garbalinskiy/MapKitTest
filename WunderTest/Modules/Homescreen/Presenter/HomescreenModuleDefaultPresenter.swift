import Foundation

class HomescreenModuleDefaultPresenter: HomescreenModulePresenter {
    
    private unowned let view: HomescreenModuleView
    private let interactor: HomescreenModuleInteractor
    private let router: HomescreenModuleRouter
    
    init(view: HomescreenModuleView,
         interactor: HomescreenModuleInteractor,
         router: HomescreenModuleRouter)
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        print("View did load")
    }
}
