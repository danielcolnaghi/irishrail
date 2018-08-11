//
//  StationSchedule.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 11/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

/* Data format received from API
 <Servertime>2018-08-10T08:53:07.063</Servertime>
 <Traincode>E906 </Traincode>
 <Stationfullname>Blackrock</Stationfullname>
 <Stationcode>BROCK</Stationcode>
 <Querytime>08:53:07</Querytime>
 <Traindate>10 Aug 2018</Traindate>
 <Origin>Greystones</Origin>
 <Destination>Howth</Destination>
 <Origintime>08:30</Origintime>
 <Destinationtime>09:48</Destinationtime>
 <Status>En Route</Status>
 <Lastlocation>Departed Dalkey</Lastlocation>
 <Duein>11</Duein>
 <Late>0</Late>
 <Exparrival>09:04</Exparrival>
 <Expdepart>09:04</Expdepart>
 <Scharrival>09:03</Scharrival>
 <Schdepart>09:04</Schdepart>
 <Direction>Northbound</Direction>
 <Traintype>DART</Traintype>
 <Locationtype>S</Locationtype>
 */

struct StationSchedule {
    
    var serverTime : Date?
    var trainCode : String?
    var stationFullName : String?
    var stationCode : String?
    var queryTime : String?
    var trainDate : Date?
    var origin : String?
    var destination : String?
    var originTime : String?
    var destinationTime : String?
    var status : String?
    var lastLocation : String?
    var dueIn : Int?
    var late : Int?
    var expArrival : String?
    var expDepart : String?
    var schArrival : String?
    var schDepart : String?
    var direction : String?
    var trainType : String?
    var locationType : String?
    
    init() {
        
    }
}
