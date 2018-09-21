import MapKit

class CarAnnotationView: MKAnnotationView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: CarMapModuleConstants.annotationSize, height: CarMapModuleConstants.annotationSize)
    }

    lazy var carImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "car"))
        imageView.frame = CGRect(x: 0, y: 0, width: CarMapModuleConstants.annotationSize, height: CarMapModuleConstants.annotationSize)
        addSubview(imageView)
        return imageView
    }()
    
    override var annotation: MKAnnotation? {
        willSet {
            isEnabled = true
            canShowCallout = true

            if let annotation = annotation as? CarAnnotation {
                carImageView.transform = carImageView.transform.rotated(by: annotation.orientation)
            }
        }
    }
    
}
