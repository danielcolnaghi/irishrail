//
//  ScheduleViewModel.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 12/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

class ScheduleViewModel {
    
    private var stations: [StationSchedule] = [StationSchedule]()
    
    func loadStations(success: @escaping () -> Void) {
        
        IrishRailAPI.shared.getStationDataByName("Blackrock", success: { (stations) in
            self.stations = stations
            success()
        }) { (error) in
            print("Woops")
        }
    }
    
    var count: Int {
        return stations.count
    }
    
    func stationAtIndex(_ index: Int) -> StationSchedule? {
        return stations[index]
    }
}
