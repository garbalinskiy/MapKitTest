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
        mapView.removeAnnotations(mapView.annotations)
        
        cars.forEach({ [unowned self] in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            annotation.title = $0.title
            self.mapView.addAnnotation(annotation)
        })
    }
    
    
}

extension CarMapModuleViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        visibleMapRect.onNext(mapView.visibleMapRect)
    }
}
