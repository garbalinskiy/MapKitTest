import Foundation

protocol ViewModelBuilder {
    
    associatedtype Model
    associatedtype ViewModel
    
    func build(_:Model) -> ViewModel
}
