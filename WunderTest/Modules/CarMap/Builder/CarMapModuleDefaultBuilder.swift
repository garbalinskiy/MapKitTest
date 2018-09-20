import Foundation
import Swinject

class CarMapModuleDefaultBuilder: CarMapModuleBuilder {
    
    private let container: Container
    
    init(container parentContainer: Container) {
        
        container = Container(parent: parentContainer)
        
        container.register(CarMapViewModelBuilder.self) { _ in
            CarMapViewModelBuilder()
        }
        
        container.register(CarMapModuleInteractor.self) { resolver in
            CarMapModuleDefaultInteractor(carRepository: resolver.resolve(CarRepository.self)!)
        }
        
        container.register(CarMapModuleRouter.self) { resolver in
            CarMapModuleDefaultRouter(viewController: resolver.resolve(CarMapModuleViewController.self)!)
        }
        
        container
            .register(CarMapModuleViewController.self) { resolver in
                CarMapModuleViewController(nibName: String(describing: CarMapModuleViewController.self), bundle: .main)
            }
            .initCompleted { resolver, viewController in
                viewController.presenter = resolver.resolve(CarMapModulePresenter.self)!
        }
        
        container.register(CarMapModulePresenter.self) { resolver in
            CarMapModuleDefaultPresenter(view: resolver.resolve(CarMapModuleViewController.self)!,
                                          router: resolver.resolve(CarMapModuleRouter.self)!,
                                          interactor: resolver.resolve(CarMapModuleInteractor.self)!,
                                          viewModelBuilder: resolver.resolve(CarMapViewModelBuilder.self)!)
        }
    }
    
    func build() -> CarMapModuleViewController {
        return container.resolve(CarMapModuleViewController.self)!
    }

}

