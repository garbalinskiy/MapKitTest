import UIKit

enum CarMapModuleConstants {
    static let annotationSize = 30
    
    static let initialLatitude: Double = 53.5456659
    static let initialLongitude: Double = 9.9950608
    static let initialRadius: Double = 2000
    
    enum DetailsView {
        static let width: CGFloat = 200
        static let height: CGFloat = 50
        static let margin: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let borderColor = Palette.grey
        static let backgroudColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
    }
}
