import Foundation

class CarEntityMapper: EntityMapper {
    
    typealias Entity = CarEntity
    typealias Model = Car
    
    func map(from model: Car) -> CarEntity {
        let entity = CarEntity()
        
        entity.address = model.address
        entity.longitude = model.coordinates.longitude
        entity.latitude = model.coordinates.latitude
        entity.orientation = model.coordinates.orientation
        
        entity.engineType = model.engineType
        entity.exterior = model.exterior.rawValue
        entity.fuel = model.fuel
        entity.interior = model.interior.rawValue
        
        entity.name = model.name
        entity.vin = model.vin
        
        return entity
    }
    
    func map(from entity: CarEntity) -> Car {
        return Car(address: entity.address,
                   coordinates: Coordinates(longitude: entity.longitude,
                                            latitude: entity.latitude,
                                            orientation: entity.orientation),
                   engineType: entity.engineType,
                   exterior: Condition(rawValue: entity.exterior) ?? .unacceptable,
                   fuel: entity.fuel,
                   interior: Condition(rawValue: entity.interior) ?? .unacceptable,
                   name: entity.name,
                   vin: entity.vin)
    }
}
