//
//  DirectionViewModel.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 12/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

class DirectionViewModel {
    
    private var stations: [StationSchedule] = [StationSchedule]()
    
    private func loadStations(success: @escaping () -> Void) {
        
        IrishRailAPI.shared.getStationDataByName("Blackrock", success: { (stations) in
            self.stations = stations
            success()
        }) { (error) in
            print("Woops")
        }
    }

    func DirectionForNorthbound(complete: @escaping () -> Void) {

    }
    
    func DirectionForSouthbound(complete: @escaping () -> Void) {
        
    }
}
