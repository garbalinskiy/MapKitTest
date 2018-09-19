import XCTest
import Mockingjay

protocol Stubable {
    var stubName: String {get}
    var stubStatusCode: Int {get}
    var stubDelay: TimeInterval {get}
}

extension Stubable {
    
    var stubDelay: TimeInterval {
        return 0.1
    }
    
    var stubStatusCode: Int {
        return 200
    }
}

extension Stubable where Self: XCTestCase {
    
    func enableStub() {
        stub(everything, delay: stubDelay, builder)
    }
    
    func builder(_ request: URLRequest) -> Response
    {
        let response = HTTPURLResponse(url: request.url!,
                                       statusCode: stubStatusCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        
        guard
            let jsonURL = Bundle(for: type(of: self)).url(forResource: stubName, withExtension: "json"),
            let data = try? Data(contentsOf: jsonURL) else
        {
            fatalError("Stub JSON file was not found for resource: \(stubName)")
        }
        
        return .success(response!, .content(data))
    }
}
