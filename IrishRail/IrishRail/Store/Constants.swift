//
//  Constants.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 11/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

struct K {
    struct APIServer {
        static let baseURL = "http://api.irishrail.ie/realtime/realtime.asmx"
    }
    
    struct APIParameterKey {
        static let stationType = "StationType"
        static let stationDesc = "StationDesc"
    }
}
