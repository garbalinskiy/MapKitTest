import Foundation

protocol EntityMapper {
    
    associatedtype Entity
    associatedtype Model
    
    func map(from: Entity) -> Model
    func map(from: Model) -> Entity
}
