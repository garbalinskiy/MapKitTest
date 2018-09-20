import Foundation
import RxSwift

protocol ApiService {
    func send<T>(_: T) -> Single<T.Response> where T : ApiRequest
}


