import Foundation
import RxSwift

protocol CarMapModuleInteractor: AnyObject {
    func findCarsInBounds(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) -> Observable<[Car]>
}
