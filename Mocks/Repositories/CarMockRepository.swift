import Foundation
import RxSwift
@testable import WunderTest

class CarMockRepository: CarRepository {
    
    var isReloaded = false
    
    func reload(_ cars: [Car]) {
        isReloaded = true
    }
    
    // MARK: - findAll
    
    let findAllCars = [
        Car(address: "Lesserstraße 170, 22049 Hamburg",
            coordinates: Coordinates(longitude: 10.07526,
                                     latitude: 53.59301,
                                     orientation: 0),
            engineType: "CE",
            exterior: .good,
            fuel: 42,
            interior: .unacceptable,
            name: "HH-GO8522",
            vin: "WME4513341K565439"),
        Car(address: "Grosse Reichenstraße 7, 20457 Hamburg",
            coordinates: Coordinates(longitude: 9.99622,
                                     latitude: 53.54847,
                                     orientation: 0),
            engineType: "CE",
            exterior: .unacceptable,
            fuel: 45,
            interior: .good,
            name: "HH-GO8480",
            vin: "WME4513341K412697")
    ]
    
    func findAll() -> Observable<[Car]> {
        return Observable.just(findAllCars)
    }
    
    // MARK: - findInBounds
    
    let findInBoundsCars = [
        Car(address: "Lesserstraße 170, 22049 Hamburg",
            coordinates: Coordinates(longitude: 10.07526,
                                     latitude: 53.59301,
                                     orientation: 0),
            engineType: "CE",
            exterior: .good,
            fuel: 42,
            interior: .unacceptable,
            name: "HH-GO8522",
            vin: "WME4513341K565439")
    ]
    
    func findInBounds(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double) -> Observable<[Car]> {
        return Observable.just(findInBoundsCars)
    }
}
