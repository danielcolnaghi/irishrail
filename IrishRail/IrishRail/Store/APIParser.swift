//
//  APIParser.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

enum ParserObjects {
    case StationSchedule
    case Station
}

class APIParser : NSObject {
    static let shared = APIParser()
    private var stationScheduleList : [StationSchedule]
    private var stationSchedule : StationSchedule!
    
    private var stationList : [Station]
    private var station : Station!
    
    private var parserObject : ParserObjects!
    private var eName = ""

    private override init() {
        stationScheduleList = [StationSchedule]()
        stationList = [Station]()
        super.init()
    }
    
    func parseStationScheduleXML(_ xml : Data) -> [StationSchedule]? {

        parserObject = .StationSchedule
        stationScheduleList.removeAll()
        let parse = XMLParser(data: xml)
        parse.delegate = self
        parse.parse()
        
        if parse.parserError == nil {
            return stationScheduleList
        } else {
            return nil
        }
    }
    
    func parseStationXML(_ xml : Data) -> [Station]? {
        
        parserObject = .Station
        stationList.removeAll()
        let parse = XMLParser(data: xml)
        parse.delegate = self
        parse.parse()
        
        if parse.parserError == nil {
            return stationList
        } else {
            return nil
        }
    }
}

extension APIParser : XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        eName = elementName
        
        if eName == "objStationData" {
            stationScheduleList.append(stationSchedule)
        } else if eName == "objStation" {
            stationList.append(station)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        
        if eName == "objStationData" {
            stationSchedule = StationSchedule()
        } else if eName == "objStation" {
            station = Station()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {

            switch parserObject {
            case .StationSchedule:
                StationScheduleParserElement(eName, data: data)
            case .Station:
                StationParserElement(eName, data: data)
            default:
                break
            }
        }
    }
    
    private func StationScheduleParserElement(_ eName: String, data: String) {
        switch eName {
        case "Stationfullname":
            stationSchedule.stationFullName = data
        case "Traincode":
            stationSchedule.trainCode = data
        case "Stationcode":
            stationSchedule.stationCode = data
        case "Exparrival":
            stationSchedule.expArrival = data
        case "Origin":
            stationSchedule.origin = data
        case "Destination":
            stationSchedule.destination = data
        case "Direction":
            stationSchedule.direction = data
        default:
            break
        }
    }
    
    private func StationParserElement(_ eName: String, data: String) {
        switch eName {
        case "StationDesc":
            station.stationDesc = data
        case "StationCode":
            station.stationCode = data
        case "StationId":
            station.stationId = data
        case "StationAlias":
            station.stationAlias = data
        case "StationLatitude":
            station.stationLatitude = data
        case "StationLongitude":
            station.stationLongitude = data
            
        default:
            break
        }
    }
}
