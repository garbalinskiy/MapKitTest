import Foundation

protocol HomescreenModulePresenter: AnyObject {
    func viewDidAppear()
    func didRequstedDataUpdate(notify: Bool)
}
