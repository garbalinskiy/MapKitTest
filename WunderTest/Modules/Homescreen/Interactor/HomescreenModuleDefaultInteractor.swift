import Foundation
import RxSwift

class HomescreenModuleDefaultInteractor: HomescreenModuleInteractor {
    
    private let syncService: SyncService
    
    init(syncService: SyncService) {
        self.syncService = syncService
    }
    
    func updateData() -> Completable {
        return syncService.updateCars()
    }
}
