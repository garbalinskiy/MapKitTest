import UIKit

class CarListModuleDefaultRouter: CarListModuleRouter {
    
    private unowned let viewController: CarListModuleViewController
    
    init(viewController: CarListModuleViewController) {
        self.viewController = viewController
    }
}
