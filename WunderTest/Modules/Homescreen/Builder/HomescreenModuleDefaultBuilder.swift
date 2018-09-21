import Foundation
import Swinject

class HomescreenModuleDefaultBuilder: HomescreenModuleBuilder {
    
    private let container: Container
    
    init(container parentContainer: Container) {
        container = Container(parent: parentContainer)
        
        container.register(HomescreenModuleInteractor.self) { resolver in
            HomescreenModuleDefaultInteractor(syncService: resolver.resolve(SyncService.self)!)
        }
        
        container.register(HomescreenModuleRouter.self) { resolver in
            HomescreenModuleDefaultRouter(viewController: resolver.resolve(HomescreenModuleViewController.self)!)
        }
        
        container
            .register(HomescreenModuleViewController.self) { resolver in
                
                let nibName = String(describing: HomescreenModuleViewController.self)
                let tabBarController = HomescreenModuleViewController(nibName: nibName, bundle: .main)
                tabBarController.tabBar.tintColor = Palette.darkGreen
                
                let carListModuleViewController = resolver.resolve(CarListModuleBuilder.self)!.build()
                carListModuleViewController.tabBarItem = UITabBarItem(title: "List",
                                                                      image: UIImage(named: HomescreenModuleConstants.MenuImageName.list),
                                                                      tag: 0)
                
                let carMapModuleViewController = resolver.resolve(CarMapModuleBuilder.self)!.build()
                carMapModuleViewController.tabBarItem = UITabBarItem(title: "Map",
                                                                     image: UIImage(named: HomescreenModuleConstants.MenuImageName.map),
                                                                     tag: 1)
                
                tabBarController.viewControllers = [
                    carListModuleViewController,
                    carMapModuleViewController
                ]

                return tabBarController
            }
            .initCompleted { resolver, viewController in
                viewController.presenter = resolver.resolve(HomescreenModulePresenter.self)!
        }
        
        container.register(HomescreenModulePresenter.self) { resolver in
            HomescreenModuleDefaultPresenter(view: resolver.resolve(HomescreenModuleViewController.self)!,
                                             interactor: resolver.resolve(HomescreenModuleInteractor.self)!,
                                             router: resolver.resolve(HomescreenModuleRouter.self)!)
        }
        
    }
    
    func build() -> HomescreenModuleViewController {
        return container.resolve(HomescreenModuleViewController.self)!
    }
}
