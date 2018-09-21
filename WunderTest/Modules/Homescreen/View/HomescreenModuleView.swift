import Foundation

protocol HomescreenModuleView: AnyObject {
    func showAlert(title: String, message: String)
    func showSyncInProgress()
    func hideSyncInProgress()
}
