import Foundation
import Swinject

class CarListModuleDefaultBuilder: CarListModuleBuilder {
    
    private let container: Container
    
    init(container parentContainer: Container) {
        
        container = Container(parent: parentContainer)
        
        container.register(CarListViewModelBuilder.self) { _ in
            CarListViewModelBuilder()
        }
        
        container.register(CarListModuleInteractor.self) { resolver in
            CarListModuleDefaultInteractor(carRepository: resolver.resolve(CarRepository.self)!)
        }
        
        container.register(CarListModuleRouter.self) { resolver in
            CarListModuleDefaultRouter(viewController: resolver.resolve(CarListModuleViewController.self)!)
        }
        
        container
            .register(CarListModuleViewController.self) { resolver in
                CarListModuleViewController(nibName: String(describing: CarListModuleViewController.self), bundle: .main)
            }
            .initCompleted { resolver, viewController in
                viewController.presenter = resolver.resolve(CarListModulePresenter.self)!
        }
        
        container.register(CarListModulePresenter.self) { resolver in
            CarListModuleDefaultPresenter(view: resolver.resolve(CarListModuleViewController.self)!,
                                          router: resolver.resolve(CarListModuleRouter.self)!,
                                          interactor: resolver.resolve(CarListModuleInteractor.self)!,
                                          viewModelBuilder: resolver.resolve(CarListViewModelBuilder.self)!)
        }
    }
    
    func build() -> CarListModuleViewController {
        return container.resolve(CarListModuleViewController.self)!
    }
}
