import UIKit

class CarAnnotationDetailsView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        frame = CGRect(x: 0,
                       y: 0,
                       width: CarMapModuleConstants.DetailsView.width,
                       height: CarMapModuleConstants.DetailsView.height)
        
        backgroundColor = CarMapModuleConstants.DetailsView.backgroudColor
        layer.borderWidth = CarMapModuleConstants.DetailsView.borderWidth
        layer.borderColor = CarMapModuleConstants.DetailsView.borderColor.cgColor
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var vinLabel: UILabel!
    
    func configureWith(annotation: CarAnnotation) {
        titleLabel.text = annotation.title
        vinLabel.text = annotation.vin
    }
}
