import MapKit

class CarAnnotationView: MKAnnotationView {
    
    private var detailsView: CarAnnotationDetailsView?
    
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

            if let annotation = annotation as? CarAnnotation {
                carImageView.transform = carImageView.transform.rotated(by: annotation.orientation)
            }
        }
    }
    
    func addDetails() {
        let detailsViewNibName = String(describing: CarAnnotationDetailsView.self)
        
        guard
            let annotation = annotation as? CarAnnotation,
            let detailsView = Bundle.main.loadNibNamed(detailsViewNibName, owner: nil, options: nil)?.first as? CarAnnotationDetailsView else
        {
            return
        }
        
        detailsView.configureWith(annotation: annotation)
        
        let detailsViewWidth = detailsView.frame.width
        let detailsViewHeight = detailsView.frame.height
        
        detailsView.frame = CGRect(x: (frame.width - detailsViewWidth) / 2,
                                   y: -1 * (detailsViewHeight + CarMapModuleConstants.DetailsView.margin),
                                   width: detailsViewWidth,
                                   height: detailsViewHeight)
        
        addSubview(detailsView)
        self.detailsView = detailsView
    }
    
    func removeDetails() {
        detailsView?.removeFromSuperview()
        detailsView = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        removeDetails()
    }
    
}
