import Foundation

protocol CarMapModulePresenter: AnyObject {
    func viewDidLoad()
    func didSelectMapArea(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double)
}
