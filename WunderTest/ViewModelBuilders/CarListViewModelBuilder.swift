import Foundation

class CarListViewModelBuilder: ViewModelBuilder {
    
    let coordinateFormat = "%.5f"
    let fuelFormat = "%.0f"
    
    typealias Model = Car
    typealias ViewModel = CarListViewModel
    
    func build(_ model: Car) -> CarListViewModel {
        
        return CarListViewModel(name: model.name,
                                vin: model.vin,
                                address: model.address,
                                coordinates: String(format: coordinateFormat, model.coordinates.latitude)
                                    + ", "
                                    + String(format: coordinateFormat, model.coordinates.longitude),
                                engineType: model.engineType,
                                fuel: String(format: fuelFormat, model.fuel),
                                exterior: name(for: model.exterior),
                                interior: name(for: model.interior)
        )
    }
    
    private func name(for condition: Condition) -> String {
        switch condition {
        case .good:
            return "Good"
        case .unacceptable:
            return "Unacceptable"
        }
    }
}
