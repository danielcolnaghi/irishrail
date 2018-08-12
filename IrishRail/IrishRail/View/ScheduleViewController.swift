//
//  ScheduleViewController.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 12/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import UIKit
import UserNotifications

class ScheduleViewController: UIViewController {

    var scheduleVM = ScheduleViewModel()
    @IBOutlet var tblStations : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scheduleVM.loadStations {
            DispatchQueue.main.async {
                self.tblStations.reloadData()
            }
        }
    }
}

extension ScheduleViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") else { return UITableViewCell() }
        
        if let station = scheduleVM.stationAtIndex(indexPath.row) {
        let stationInfo = "\(station.direction ?? "") \(station.origin ?? "") TO \(station.destination ?? "") \(station.expArrival ?? "")"
            
            cell.textLabel?.text = stationInfo
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let content = UNMutableNotificationContent()
        content.title = "DART"
        content.body = "Your train arrives in 10 minutes."
        content.sound = UNNotificationSound.default()
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let date = Date(timeIntervalSinceNow: 10)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = "DARTNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
