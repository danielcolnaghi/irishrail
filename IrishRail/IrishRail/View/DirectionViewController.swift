//
//  DirectionViewController.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 12/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import UIKit
import UserNotifications

class DirectionViewController: UIViewController {

    @IBOutlet weak var lblStation: UILabel!
    var directionVM = DirectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Created for a possible selection in the Station Tab
        lblStation.text = "Blackrock"
    }
    
    @IBAction func btnNorthbound_Touch(_ sender: UIButton) {
        directionVM.DirectionForNorthbound(success: { (date) in
            self.requestNotificationForDate(date)
        }) { (error) in
            self.alertOk("No DART available.")
        }
    }
    
    @IBAction func btnSouthbound_Touch(_ sender: UIButton) {
        directionVM.DirectionForSouthbound(success: { (date) in
            self.requestNotificationForDate(date)
        }) { (error) in
            self.alertOk("No DART available.")
        }
    }
    
    func requestNotificationForDate(_ date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "DART"
        content.body = "Your train arrives in 10 minutes."
        content.sound = UNNotificationSound.default()
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = "DARTNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
                self.alertOk("Notification error: \(error.localizedDescription)")
            } else {
                self.alertOk("Notification scheduled to \(date)")
            }
        })
    }
    
    func alertOk(_ msg: String) {
        let alertController = UIAlertController(title: "DART", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
