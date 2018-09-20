import Foundation
import RxSwift

class RepositorySyncService: SyncService {
    
    private let apiService: ApiService
    private let carRepository: CarRepository
    
    init(apiService: ApiService, carRepository: CarRepository) {
        self.apiService = apiService
        self.carRepository = carRepository
    }
    
    func updateCars() -> Completable {
        let request = LocationsApiRequest()
        return apiService.send(request).map({ [weak self] response in
            self?.carRepository.reload(response.placemarks)
        }).asCompletable()
    }
}
