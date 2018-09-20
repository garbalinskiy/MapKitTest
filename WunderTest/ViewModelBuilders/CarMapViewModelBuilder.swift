import Foundation

class CarMapViewModelBuilder: ViewModelBuilder {
    typealias Model = Car
    typealias ViewModel = CarMapViewModel
    
    func build(_ car: Car) -> CarMapViewModel {
        return CarMapViewModel(title: car.name,
                               latitude: car.coordinates.latitude,
                               longitude: car.coordinates.longitude)
    }
}
