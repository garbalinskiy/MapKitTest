import Foundation
import RxSwift

protocol CarRepository {
    func reload(_: [Car])
    func findAll() -> Observable<[Car]>
    func findInBounds(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) -> Observable<[Car]>
}
