import Foundation
import RxSwift

protocol HomescreenModuleInteractor {
    func updateData() -> Completable
}
