//
//  StationViewController.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import UIKit

class StationViewController: UIViewController {

    var stationVM = StationViewModel()
    @IBOutlet var tblStations : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationVM.loadStations {
            DispatchQueue.main.async {
                self.tblStations.reloadData()
            }
        }
    }
}

extension StationViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell") else { return UITableViewCell() }
        
        if let station = stationVM.stationAtIndex(indexPath.row) {
            
            let stationInfo = "\(station.stationDesc ?? "") \(station.stationAlias ?? "")"
            cell.textLabel?.text = stationInfo
        }
        
        return cell
    }
}
