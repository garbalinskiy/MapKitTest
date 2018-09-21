import Foundation
@testable import WunderTest

class CarListModuleMockView: CarListModuleView {
    
    var shownCars: [CarListViewModel] = []
    
    func showCars(_ cars: [CarListViewModel]) {
        shownCars = cars
    }

}
