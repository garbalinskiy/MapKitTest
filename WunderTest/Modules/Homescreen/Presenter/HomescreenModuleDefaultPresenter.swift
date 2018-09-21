import Foundation
import RxSwift

class HomescreenModuleDefaultPresenter: HomescreenModulePresenter {
    
    private unowned let view: HomescreenModuleView
    private let interactor: HomescreenModuleInteractor
    private let router: HomescreenModuleRouter
    
    let disposeBag = DisposeBag()
    
    var shouldPresertShakeToUpdateHint = true
    var isUpdatingData = false
    
    init(view: HomescreenModuleView,
         interactor: HomescreenModuleInteractor,
         router: HomescreenModuleRouter)
    {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        didRequstedDataUpdate(notify: false)
    }
    
    func viewDidAppear() {
        if shouldPresertShakeToUpdateHint {
            view.showAlert(title: "FAQ", message: "To update data on device please shake it")
        }
    }
    
    func didRequstedDataUpdate(notify: Bool = true) {
        if isUpdatingData {
            return
        }
        
        view.showSyncInProgress()
        
        isUpdatingData = true
        
        interactor.updateData().subscribe(
            onCompleted: { [weak self] in
                self?.isUpdatingData = false
                self?.view.hideSyncInProgress()
                if notify {
                    self?.view.showAlert(title: "Success", message: "Synchronization is done and new data is available")
                }
            },
            onError: { [weak self] error in
                self?.isUpdatingData = false
                self?.view.hideSyncInProgress()
                self?.view.showAlert(title: "Error", message: "Synchronization failed")
            }
        ).disposed(by: disposeBag)
        
    }
}
