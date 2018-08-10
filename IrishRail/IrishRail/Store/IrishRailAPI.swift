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
    
    func getStationDataByNameXML(_ StationDesc: String, success: @escaping (_ station: [Station]) -> Void, errorMessage: @escaping (String) -> Void) {
        
        //http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=Blackrock
        let url = URL(string: "http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=Blackrock")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
                return
            }

            if let data = data {
                
                // decode data
                if let stations = APIParser.shared.parseStationXML(data) {
                    success(stations)
                } else {
                    errorMessage("XML decoder fail with data: \(String(data: data, encoding: .utf8) ?? "")")
                }
                    
            }
            
        }.resume()
    }
}
