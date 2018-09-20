import Foundation
import RxSwift

class CarMapModuleDefaultInteractor: CarMapModuleInteractor {
    
    private let carRepository: CarRepository
    
    init(carRepository: CarRepository) {
        self.carRepository = carRepository
    }
    
    func findCarsInBounds(minLongitude: Double,
                          minLatitude: Double,
                          maxLongitude: Double,
                          maxLatitude: Double) -> Observable<[Car]>
    {
        return carRepository.findInBounds(minLongitude: minLongitude,
                                          minLatitude: minLatitude,
                                          maxLongitude: maxLongitude,
                                          maxLatitude: maxLatitude)
    }
    
    
}
