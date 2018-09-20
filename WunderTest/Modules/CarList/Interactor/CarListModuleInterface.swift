import Foundation
import RxSwift

protocol CarListModuleInteractor: AnyObject {
    func findCars() -> Observable<[Car]>
}
