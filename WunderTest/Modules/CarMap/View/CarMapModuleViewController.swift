import UIKit
import MapKit
import RxSwift

class CarMapModuleViewController: UIViewController {
    
    var presenter: CarMapModulePresenter!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let visibleMapRect = PublishSubject<MKMapRect>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
    }
    
    func initMapView() {
    
        mapView.register(CarAnnotationView.self, forAnnotationViewWithReuseIdentifier: "CarAnnotation")
        
        mapView.delegate = self
        
        visibleMapRect.debounce(0.1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] mapRect in
            let (lowerBound, upperBound) = mapRect.boundsCoordinates
            self?.presenter.didSelectMapArea(minLongitude: lowerBound.longitude,
                                       minLatitude: lowerBound.latitude,
                                       maxLongitude: upperBound.longitude,
                                       maxLatitude: upperBound.latitude)
            
        }).disposed(by: disposeBag)
    }
}

extension CarMapModuleViewController: CarMapModuleView {
    
    func showCars(_ cars: [CarMapViewModel]) {
        
        let currentsAnnotations = mapView.annotations.compactMap({ $0 as? CarAnnotation })
        let currentAnnotationsVins = Set(currentsAnnotations.map({ $0.vin }))
        var obsoleteAnnotationVins = currentAnnotationsVins
        
        cars.forEach({ [unowned self] car in
            
            obsoleteAnnotationVins.remove(car.vin)
            
            if currentAnnotationsVins.contains(car.vin) {
                return
            }
            
            let annotation = CarAnnotation(title: car.title,
                                           vin: car.vin,
                                           coordinate: CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude),
                                           orientation: car.orientation)
            
            self.mapView.addAnnotation(annotation)
        })
        
        mapView.removeAnnotations(currentsAnnotations.filter({ obsoleteAnnotationVins.contains($0.vin) }))
    }
    
    
}

extension CarMapModuleViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        visibleMapRect.onNext(mapView.visibleMapRect)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view =  mapView.dequeueReusableAnnotationView(withIdentifier: "CarAnnotation", for: annotation)
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Selected a car")
    }
}
