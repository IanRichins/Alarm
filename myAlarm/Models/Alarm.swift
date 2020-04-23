import Foundation


class Alarm {
    
    // MARK: @Properties
    var fireDate: Date
    var name: String
    var enabled: Bool
    // The uuid on the Alarm object will be used later
    // to schedule and cancel local notifications
    var uuid: String
    
    // MARK: @Computed Properties
    /**©------------------------------------------------------------------------------©*/
    var fireTimeAsString: String = {
        let today = Date()
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .medium
        let result = formatter2.string(from: today)
        
        return result
    }()
    /**©------------------------------------------------------------------------------©*/
    
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        lhs.fireDate == rhs.fireDate &&
            lhs.name == rhs.name &&
            lhs.name == rhs.name &&
            lhs.fireTimeAsString == rhs.fireTimeAsString
    }
}
