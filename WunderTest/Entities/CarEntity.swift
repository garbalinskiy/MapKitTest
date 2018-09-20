import Foundation
import RealmSwift

@objcMembers
class CarEntity: Object {
    
    dynamic var address = ""
    
    dynamic var longitude: Double = 0
    dynamic var latitude: Double = 0
    dynamic var orientation: Double = 0
    
    dynamic var engineType = ""
    dynamic var exterior = ""
    dynamic var fuel: Double = 0
    dynamic var interior = ""
    
    dynamic var name = ""
    dynamic var vin = ""
    
    override static func primaryKey() -> String? {
        return "vin"
    }
}
