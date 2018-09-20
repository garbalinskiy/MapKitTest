import UIKit

class CarMapModuleViewController: UIViewController {
    
    var presenter: CarMapModulePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension CarMapModuleViewController: CarMapModuleView {
    
}
