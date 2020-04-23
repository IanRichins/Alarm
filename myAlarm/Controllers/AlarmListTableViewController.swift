import UIKit

protocol AlarmTableViewCellDelegate: class {
    func alarmsWasToggled(sender: AlarmTableViewCell)
}

class AlarmListTableViewController: UITableViewController, AlarmTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /**©------------------------------------------------------------------------------©*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func alarmsWasToggled(sender: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleIsOn(for: alarm)
    }
    /**©------------------------------------------------------------------------------©*/

    // MARK: - Table view data source
    /**©------------------------------------------------------------------------------©*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath)
                as? AlarmTableViewCell else { return UITableViewCell() }

        let alarmToUpdate = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        cell.alarms = alarmToUpdate

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alarmToDelete = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(oldAlarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toAlarmVC" else {
            return
        }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        let destinationVC = segue.destination as? AlarmDetailTableViewController
        destinationVC?.alarm = alarm
    }
    /**©------------------------------------------------------------------------------©*/
}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {

    func switchCellSwitchValueChanged(for cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let settingsToChange = AlarmController.shared.alarms[indexPath.row]

        AlarmController.shared.toggleIsOn(for: settingsToChange)
        cell.updateView(with: settingsToChange)
    }
}
