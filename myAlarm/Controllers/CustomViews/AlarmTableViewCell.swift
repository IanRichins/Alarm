import UIKit

// MARK: _Protocol delegate
/**©------------------------------------------------------------------------------©*/
/// STEP 1: Declaring a protocol delegate
protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(for cell: AlarmTableViewCell)
}

/**©------------------------------------------------------------------------------©*/

class AlarmTableViewCell: UITableViewCell {
    
    /**©------------------------------------------------------------------------------©*/
    // MARK: _@IBOutlet
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    // MARK: @Properties
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarms: Alarm? {
        didSet {
            guard let newAlarm = alarms else { return }
            updateView(with: newAlarm)
        }
    }
    
    /**©------------------------------------------------------------------------------©*/
    // MARK: _HELPER
    func updateView(with updateAlarm: Alarm) {
        nameLabel.text = updateAlarm.name
        timeLabel.text = updateAlarm.fireTimeAsString
        alarmSwitch.isOn = updateAlarm.enabled
    }
    
    // MARK: _@IBAction
    @IBAction func switchValueChanged(_ sender: Any) {
        
    }
    
    /**©------------------------------------------------------------------------------©*/
}


