import Foundation
@testable import WunderTest

class CarMapModuleMockView: CarMapModuleView {
    
    var shownCars: [CarMapViewModel] = []
    
    func showCars(_ cars: [CarMapViewModel]) {
        shownCars = cars
    }
    
}
