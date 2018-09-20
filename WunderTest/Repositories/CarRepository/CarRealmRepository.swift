import Foundation
import RealmSwift
import RxSwift

class CarRealmRepository: CarRepository {
    
    private let realm: Realm
    private let entityMapper: CarEntityMapper
    
    init(realm: Realm,
         entityMapper: CarEntityMapper) {
        self.realm = realm
        self.entityMapper = entityMapper
    }
    
    func findAll() -> Observable<[Car]> {
        return Observable.create { [unowned self] observer in
    
            let fetchResult = self.realm.objects(CarEntity.self)
            
            let notificationToken = fetchResult.observe { [weak self] _ in
                guard let `self` = self else { return }
                observer.onNext(fetchResult.map({ self.entityMapper.map(from: $0)}))
            }
            
            return Disposables.create {
                notificationToken.invalidate()
            }
        }
    }
    
    func reload(_ cars: [Car]) {
        try! realm.write {
            realm.deleteAll()
            realm.add(cars.map({ entityMapper.map(from: $0)}))
        }
    }
}
