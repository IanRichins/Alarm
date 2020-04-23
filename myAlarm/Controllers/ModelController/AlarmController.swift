import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    var alarms: [Alarm] = []
    
    init() {
        self.alarms = self.mockAlarms
    }
    // MARK: @Property
    let mockAlarms:[Alarm] = {
        let gymWorkout = Alarm(fireDate: Date(), name: "Gym-Time", enabled: false)
        let walkDog = Alarm(fireDate: Date(), name: "Walk-Dog", enabled: false)
        let dateNight = Alarm(fireDate: Date(), name: "Date-Night", enabled: true)
        
        return [gymWorkout, walkDog, dateNight]
    }()
    /**©------------------------------------------------------------------------------©*/
    // MARK: _CRUD
    
    func toggleIsOn(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    // CREATE
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
    }
    
    /// READ() if we have data to read
    
    
    // UPDATE
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
    }
    
    // DELETE
    func delete(oldAlarm: Alarm) {
        guard let index = alarms.firstIndex(of: oldAlarm) else { return }
        alarms.remove(at: index)
    }
    
    /**©------------------------------------------------------------------------------©*/
}

