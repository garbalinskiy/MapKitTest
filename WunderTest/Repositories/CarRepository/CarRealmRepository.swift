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
    
    func reload(_ cars: [Car]) {
        try! realm.write {
            realm.deleteAll()
            realm.add(cars.map({ entityMapper.map(from: $0)}))
        }
    }
    
    private func observable(with predicate: NSPredicate? = nil) -> Observable<[Car]> {
        return Observable.create { [unowned self] observer in
            
            var fetchResult = self.realm.objects(CarEntity.self)
            
            if let predicate = predicate {
                fetchResult = fetchResult.filter(predicate)
            }
            
            let notificationToken = fetchResult.observe { [weak self] _ in
                guard let `self` = self else { return }
                observer.onNext(fetchResult.map({ self.entityMapper.map(from: $0)}))
            }
            
            return Disposables.create {
                notificationToken.invalidate()
            }
        }
    }
    
    func findAll() -> Observable<[Car]> {
        return observable()
    }
    
    func findInBounds(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) -> Observable<[Car]> {
        
        let predicate = NSPredicate(format: "latitude >= %@ AND latitude <= %@ AND longitude >= %@ AND longitude <= %@",
                                    argumentArray: [minLatitude, maxLatitude, minLongitude, maxLongitude])
        
        return observable(with: predicate)
    }
}
