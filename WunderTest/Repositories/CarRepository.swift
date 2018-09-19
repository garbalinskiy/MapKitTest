import Foundation
import RxSwift

protocol CarRepository {
    func findAll() -> Observable<[Car]>
    func reload(_:[Car])
}
