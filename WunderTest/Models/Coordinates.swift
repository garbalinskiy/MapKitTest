import Foundation

struct Coordinates: Decodable, Equatable {
    
    let longitude: Double
    let latitude: Double
    let orientation: Double
    
    init(longitude: Double, latitude: Double, orientation: Double) {
        self.longitude = longitude
        self.latitude = latitude
        self.orientation = orientation
    }
    
    init(from decoder: Decoder) throws {
        
        let arrayContainer = try decoder.singleValueContainer()
        let coordinatesArray = try arrayContainer.decode([Double].self)
        
        if coordinatesArray.count < 3 {
            throw DecodingError.dataCorruptedError(in: arrayContainer, debugDescription: "Not enough data to decode to Coordinates struct")
        }
        
        longitude = coordinatesArray[0]
        latitude = coordinatesArray[1]
        orientation = coordinatesArray[2]
    }
}
