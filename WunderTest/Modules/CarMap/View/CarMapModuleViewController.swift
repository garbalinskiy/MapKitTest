import UIKit
import MapKit
import RxSwift

class CarMapModuleViewController: UIViewController {
    
    var presenter: CarMapModulePresenter!
    
    private let disposeBag = DisposeBag()
    private let visibleMapRect = PublishSubject<MKMapRect>()
    private var mapRectCars: [CarMapViewModel] = []
    private var selectedCar: CarMapViewModel?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
    }
    
    func initMapView() {
        
        mapView.register(CarAnnotationView.self, forAnnotationViewWithReuseIdentifier: "CarAnnotation")
        
        mapView.delegate = self
        
        let initialCenterLocation = CLLocationCoordinate2D(latitude: CarMapModuleConstants.initialLatitude,
                                                           longitude: CarMapModuleConstants.initialLongitude)
        
        mapView.setRegion(MKCoordinateRegion(center: initialCenterLocation,
                                             latitudinalMeters: CarMapModuleConstants.initialRadius,
                                             longitudinalMeters: CarMapModuleConstants.initialRadius),
                          animated: false)
        
        visibleMapRect.debounce(0.1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] mapRect in
            let (lowerBound, upperBound) = mapRect.boundsCoordinates
            self?.presenter.didSelectMapArea(minLongitude: lowerBound.longitude,
                                             minLatitude: lowerBound.latitude,
                                             maxLongitude: upperBound.longitude,
                                             maxLatitude: upperBound.latitude)
            
        }).disposed(by: disposeBag)
        
        mapViewDidChangeVisibleRegion(mapView)
    }
    
    func cancelSelection() {
        print("canceled")
    }
}

extension CarMapModuleViewController: CarMapModuleView {
    
    func showCars(_ cars: [CarMapViewModel]) {
        
        mapRectCars = cars
        
        if selectedCar != nil {
            return
        }
        
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
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "CarAnnotation", for: annotation) as! CarAnnotationView
        
        if let viewAnnotation = view.annotation as? CarAnnotation, viewAnnotation.vin == selectedCar?.vin {
            view.addDetails()
        } else {
            view.removeDetails()
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard
            let view = view as? CarAnnotationView,
            let selectedAnnotation = view.annotation as? CarAnnotation,
            let newSelectedCar = mapRectCars.first(where: { $0.vin == selectedAnnotation.vin }) else
        {
                return
        }
        
        // In case second tap reset selection
        if selectedCar?.vin == newSelectedCar.vin {
            selectedCar = nil
            view.removeDetails()
            showCars(mapRectCars)
            return
        } else {
            selectedCar = newSelectedCar
            view.addDetails()
        }
        
        mapView.deselectAnnotation(selectedAnnotation, animated: false)
        
        let annotationToRemove = mapView.annotations.filter({ annotation in
            guard let annotation = annotation as? CarAnnotation else { return true }
            return annotation != selectedAnnotation
        })
        
        mapView.removeAnnotations(annotationToRemove)
    }
}
