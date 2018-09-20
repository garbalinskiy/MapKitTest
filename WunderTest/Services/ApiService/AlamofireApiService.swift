import Foundation
import Alamofire
import RxSwift

class AlamofireApiService: ApiService {
    
    private let config: ConfigService
    
    init(config: ConfigService) {
        self.config = config
    }
    
    func send<T>(_ request: T) -> Single<T.Response> where T : ApiRequest {
        return Single.create { [unowned self] single in
            
            guard let url = URL(string: self.config.apiBasePath + request.path) else
            {
                single(.error(ApiServiceError.invalidRequestPath))
                return Disposables.create()
            }
            
            Alamofire
                .request(url,
                         method: .get,
                         parameters: request.parameters,
                         encoding: URLEncoding.default,
                         headers: nil)
                .responseData{ response in
                    
                    if let error = response.error {
                        single(.error(error))
                        return
                    }
                    
                    guard let data = response.data else {
                        single(.error(ApiServiceError.noDataInResponse))
                        return
                    }
                    
                    do {
                        let decodedResponse = try request.response(from: data)
                        single(.success(decodedResponse))
                    } catch {
                        single(.error(error))
                    }
            }
            
            return Disposables.create()
        }
    }
}
