import Foundation
import Swinject
import RealmSwift

extension Container {
    static let `default`: Container = {
        let container = Container()
        
        container.register(ConfigService.self) { _ in
            DefaultConfigService()
        }
        
        container.register(Realm.self) { _ in
            let realm = try! Realm()
            print("Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm")
            print(Realm.Configuration.defaultConfiguration.fileURL)
            print("Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm - Realm")
            return realm
        }
        
        container.register(ApiService.self) { resolver in
            AlamofireApiService(config: resolver.resolve(ConfigService.self)!)
        }
        
        //
        // Register Entity Mappers and Repositories
        // For a moment here is only only, but later can be added more
        // Usually mappers have dependencies on another mappers, but not in case on really small task
        //
        
        container.register(CarEntityMapper.self) { _ in
            CarEntityMapper()
        }
        
        container.register(CarRepository.self) { resolver in
            CarRealmRepository(realm: resolver.resolve(Realm.self)!,
                                      entityMapper: resolver.resolve(CarEntityMapper.self)!)
        }
        
        container.register(SyncService.self) { resolver in
            RepositorySyncService(apiService: resolver.resolve(ApiService.self)!,
                                  carRepository: resolver.resolve(CarRepository.self)!)
        }
        
        //
        // Register module builders
        //
        
        container.register(HomescreenModuleBuilder.self) { _ in HomescreenModuleDefaultBuilder(container: container) }
        container.register(CarListModuleBuilder.self) { _ in CarListModuleDefaultBuilder(container: container) }
        container.register(CarMapModuleBuilder.self) { _ in CarMapModuleDefaultBuilder(container: container) }
        
        return container
    }()
}
