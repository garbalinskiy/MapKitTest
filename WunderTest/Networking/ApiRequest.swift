import Foundation

protocol ApiRequest {
    
    associatedtype Response
    
    var path: String {get}
    var parameters: [String: Any] {get}
    
    func response(from data: Data) throws -> Response
}
