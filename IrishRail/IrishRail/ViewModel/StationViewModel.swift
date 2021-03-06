//
//  StationViewModel.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

class StationViewModel {
    
    private var stations: [Station] = [Station]()
    
    func loadStations(success: @escaping () -> Void) {
        
        // (A)ll (M)ainline (S)uburban (D)ART
        IrishRailAPI.shared.getAllStationsWithType("D", success: { (stations) in
            self.stations = stations
            success()
        }) { (error) in
            print("Woops")
        }
    }
    
    var count: Int {
        return stations.count
    }
    
    func stationAtIndex(_ index: Int) -> Station? {
        return stations[index]
    }
}
