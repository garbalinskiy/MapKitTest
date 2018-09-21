
import UIKit

class HomescreenModuleViewController: UITabBarController {
    
    var presenter: HomescreenModulePresenter!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        presenter.didRequstedDataUpdate(notify: true)
    }
}

extension HomescreenModuleViewController: HomescreenModuleView {
    
    func showAlert(title: String, message: String) {
        let arertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        arertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(arertController, animated: true, completion: nil)
    }
    
    func showSyncInProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideSyncInProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
