//
//  ScheduleViewController.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 12/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    var scheduleVM = ScheduleViewModel()
    @IBOutlet var tblStations : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
}
