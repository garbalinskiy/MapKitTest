import Foundation

class CarListViewModelBuilder: ViewModelBuilder {
    
    let coordinateFormat = "%.5f"
    
    typealias Model = Car
    typealias ViewModel = CarListViewModel
    
    func build(_ model: Car) -> CarListViewModel {
        
        return CarListViewModel(vin: model.vin,
                                name: model.name,
                                address: model.address,
                                longitude: String(format: coordinateFormat, model.coordinates.longitude),
                                latitude: String(format: coordinateFormat, model.coordinates.latitude),
                                engineType: model.engineType,
                                fuel: model.fuel,
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
