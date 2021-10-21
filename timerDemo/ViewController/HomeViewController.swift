import UIKit

class HomeViewController: UIViewController {
    
    var days = 0
    var hours = 0
    var min = 0
    var sec = 0
    var timer = Timer()
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblMinutes: UILabel!
    @IBOutlet weak var lblSeconds: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        startingTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: Button Actions
extension HomeViewController {
    @IBAction func btnPressAction(_ sender: Any) {
        self.lblDays.text = "00"
        self.lblHours.text = "00"
        self.lblMinutes.text = "00"
        self.lblSeconds.text = "00"
        timerStart()
    }
    
    @IBAction func btnLogAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Methods
extension HomeViewController {
    
    //for display starting timer
    func startingTimer() {
        if isKeyPresentInUserDefaults(key: "lastData") {
            self.lblDays.text = ""
            self.lblHours.text = ""
            self.lblMinutes.text = ""
            self.lblSeconds.text = ""
            let startDate = UserDefaults.standard.object(forKey: "lastData") as! Date
            days = (Date().days(from: startDate))
            hours = (Date().hours(from: startDate)) - (Int((Date().hours(from: startDate)) / 24) * 24)
            min = (Date().minutes(from: startDate)) - (Int((Date().minutes(from: startDate)) / 60) * 60)
            sec = (Date().seconds(from: startDate)) - (Int((Date().seconds(from: startDate)) / 60) * 60)
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    func timerStart() {
        sec = 0
        min = 0
        hours = 0
        days = 0
        if isKeyPresentInUserDefaults(key: "lastData") {
            DataInfo().createData(startDate: UserDefaults.standard.object(forKey: "lastData") as! Date, endDate: Date())
        }
        UserDefaults.standard.set(Date(), forKey: "lastData")
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    //Check key is present in UserDefaults
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    @objc func timerAction() {
        sec += 1
        if sec > 59 {
            sec = 0
            min += 1
            if min > 59 {
                min = 0
                hours += 1
                if hours > 23 {
                    hours = 0
                    days += 1
                }
            }
        }
        if days < 10 {
            self.lblDays.text = "0\(days)"
        } else {
            self.lblDays.text = "\(days)"
        }
        
        if hours < 10 {
            self.lblHours.text = "0\(hours)"
        } else {
            self.lblHours.text = "\(hours)"
        }
        
        if min < 10 {
            self.lblMinutes.text = "0\(min)"
        } else {
            self.lblMinutes.text = "\(min)"
        }
        
        if sec < 10 {
            self.lblSeconds.text = "0\(sec)"
        } else {
            self.lblSeconds.text = "\(sec)"
        }
    }
    
    @objc func appMovedToForeground() {
        startingTimer()
    }
}
