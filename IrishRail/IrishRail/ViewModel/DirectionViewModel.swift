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
        
        IrishRailAPI.shared.getStationDataByName("Blackrock", minute: 20, success: { (stations) in
            self.stations = stations
            success()
        }) { (error) in
            print("Woops")
        }
    }

    func DirectionForNorthbound(success: @escaping (_ date: Date) -> Void, errorMessage: @escaping (String) -> Void) {
        
        loadStations {
            var noDart = true
            for schedule in self.stations {
                if schedule.direction == "Northbound" {
                    // Get expected time of arrive
                    guard let strDate = schedule.expArrival else { errorMessage("No DART available.");return }
                    let expArrivalDate = self.dateWithHourString(strDate)
                    
                    let components = Calendar.current.dateComponents([.minute], from: Date(), to: expArrivalDate)
                    if components.minute! > 0 {
                        noDart = false
                        success(expArrivalDate)
                        break
                    }
                }
            }
            if noDart { errorMessage("No DART available.") }
        }
    }
    
    func DirectionForSouthbound(success: @escaping (_ date: Date) -> Void, errorMessage: @escaping (String) -> Void) {
        
        loadStations {
            var noDart = true
            for schedule in self.stations {
                if schedule.direction == "Southbound" {
                    // Get expected time of arrive
                    guard let strDate = schedule.expArrival else { errorMessage("No DART available.");return }
                    let expArrivalDate = self.dateWithHourString(strDate)
                    
                    let components = Calendar.current.dateComponents([.minute], from: Date(), to: expArrivalDate)
                    if components.minute! > 0 {
                        noDart = false
                        success(expArrivalDate)
                        break
                    }
                }
            }
            if noDart { errorMessage("No DART available.") }
        }
    }
    
    func dateWithHourString(_ hour: String) -> Date {
        let dateComp = hour.components(separatedBy: ":")

        let calendar = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())

        var timeInterval = DateComponents()
        timeInterval.year = calendar.year
        timeInterval.month = calendar.month
        timeInterval.day = calendar.day
        timeInterval.hour = Int(dateComp[0])!
        timeInterval.minute = Int(dateComp[1])! - 10
        timeInterval.second = 0

        let expArrivalDate = Calendar.current.date(from: timeInterval)!
        
        return expArrivalDate
    }
}
