
import UIKit

class HomescreenModuleViewController: UITabBarController {
    
    var presenter: HomescreenModulePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

//        presenter.viewDidLoad()
    }

}

extension HomescreenModuleViewController: HomescreenModuleView {
    
}
