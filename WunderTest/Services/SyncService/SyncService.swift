import Foundation
import RxSwift

protocol SyncService {
    func updateCars() -> Completable
}
