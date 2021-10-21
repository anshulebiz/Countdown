import UIKit

class LogViewController: UIViewController {

    var logList = [LogStore]()
    
    @IBOutlet weak var tblLogList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblLogList.register(UINib(nibName: "LogDetailCell", bundle: nil), forCellReuseIdentifier: "LogDetailCell")
        tblLogList.separatorStyle = .none
        logList = DataInfo().retriveData()
    }

}

//MARK: Button Actions
extension LogViewController {
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: TableView Methods
extension LogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogDetailCell", for: indexPath) as! LogDetailCell
        let data = logList[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy   HH:mm"
        cell.lblStartDate.text = dateFormatter.string(from: data.startDate ?? Date())
        cell.lblEndDate.text = dateFormatter.string(from: data.endDate ?? Date())
        let days = data.endDate?.days(from: data.startDate!)
        let hours = (data.endDate?.hours(from: data.startDate!) ?? 0) - (Int((data.endDate?.hours(from: data.startDate!) ?? 0) / 24) * 24)
        let min = (data.endDate?.minutes(from: data.startDate!) ?? 0) - (Int((data.endDate?.minutes(from: data.startDate!) ?? 0) / 60) * 60)
        let sec = (data.endDate?.seconds(from: data.startDate!) ?? 0) - (Int((data.endDate?.seconds(from: data.startDate!) ?? 0) / 60) * 60)
        cell.lblDifference.text = "\(days ?? 0)d \(hours)h \(min)m \(sec)s"
        cell.selectionStyle = .none
        return cell
    }
}
