//
//  IrishRailAPI.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

class IrishRailAPI {
    
    static let shared = IrishRailAPI()
    
    private init() {}
    
    func getStationDataByName(_ name: String, success: @escaping (_ station: [StationSchedule]) -> Void, errorMessage: @escaping (String) -> Void) {
        
        guard let request = try? APIRouter.stationsByName(name).asURLRequest() else {
            errorMessage("API URL Error")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
                return
            }

            if let data = data {
                // Parse Station XML from Data
                if let stations = APIParser.shared.parseStationScheduleXML(data) {
                    success(stations)
                } else {
                    errorMessage("XML decoder fail with data: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }
            
        }.resume()
    }
    
    /*
        Returns a list of all stations with
            StationDesc, StaionCode, StationId, StationAlias, StationLatitude and StationLongitude
            Ordered by Latitude, Longitude
            Filtered by StationType
     
        Takes a single letter with 4 possible values for the StationType parameter
            (A for All, M for Mainline, S for suburban and D for DART)
            any other value will be changed to A
     */
    func getAllStationsWithType(_ type: String, success: @escaping (_ station: [Station]) -> Void, errorMessage: @escaping (String) -> Void) {
        
        guard let request = try? APIRouter.allStationsWithType(type).asURLRequest() else {
            errorMessage("API URL Error")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                
                // Parse Station XML from Data
                if let stations = APIParser.shared.parseStationXML(data) {
                    success(stations)
                } else {
                    errorMessage("XML decoder fail with data: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }
            
            }.resume()
    }
}
