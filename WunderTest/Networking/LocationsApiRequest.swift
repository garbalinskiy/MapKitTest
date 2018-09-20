import Foundation

class LocationsApiRequest: ApiRequest {
    struct Response: Decodable {
        let placemarks: [Car]
    }
    
    let path = "/locations.json"
    let parameters: [String: Any] = [:]
    
    func response(from data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
