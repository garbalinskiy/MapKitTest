import Foundation
import RxSwift

class CarListModuleDefaultInteractor: CarListModuleInteractor {
    
    private let carRepository: CarRepository
    
    init(carRepository: CarRepository) {
        self.carRepository = carRepository
    }
    
    func findCars() -> Observable<[Car]> {
        return carRepository.findAll()
    }
}
