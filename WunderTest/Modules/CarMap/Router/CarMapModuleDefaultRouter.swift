import Foundation

class CarMapModuleDefaultRouter: CarMapModuleRouter {
    
    private unowned let viewController: CarMapModuleViewController
    
    init(viewController: CarMapModuleViewController) {
        self.viewController = viewController
    }
}
