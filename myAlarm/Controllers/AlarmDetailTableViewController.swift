import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    // MARK: _@IBOutlet
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sectionNameLabel: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    // MARK: _@Properties
    var alarmIsOn: Bool = true

    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            self.updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        enableButton.layer.cornerRadius = 13.0
    }
    
    // MARK: _@IBAction
    @IBAction func enableButtonTapped(_ sender: Any) {
        if let defaultAlarm = alarm {
            AlarmController.shared.toggleIsOn(for: defaultAlarm)
            alarmIsOn = defaultAlarm.enabled
        } else {
            alarmIsOn = !alarmIsOn
        }
        setupAlarmBtn()
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        guard let title = sectionNameLabel.text else { return }
        guard title != "[DID NOT SAVE]" else { return }

        if let defaultAlarm = alarm {
            AlarmController.shared.update(
                    alarm: defaultAlarm, fireDate: datePicker.date,
                    name: title, enabled: alarmIsOn
            )
        } else {
            AlarmController.shared.addAlarm(
                    fireDate: datePicker.date,
                    name: title,
                    enabled: alarmIsOn
            )
        }
        self.navigationController?.popViewController(animated: true)
    }

    /**©------------------------------------------------------------------------------©*/
    private func setupAlarmBtn() {
        switch alarmIsOn {
        case true:
            enableButton.backgroundColor = .red
            enableButton.setTitle("ON/Prendido", for: .focused)
        case false:
            enableButton.backgroundColor = .black
            enableButton.setTitle("OFF/Apagado", for: .focused)
        }
    }

    func updateViews() {
        // Unwrapping the optional alarm:Bool
        guard let defaultAlarm = alarm else { return }
        alarmIsOn = defaultAlarm.enabled
        datePicker.date = defaultAlarm.fireDate
        sectionNameLabel.text = defaultAlarm.name

        setupAlarmBtn()
    }

    /**©------------------------------------------------------------------------------©*/
}
