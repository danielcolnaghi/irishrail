//
//  APIParser.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 10/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

class APIParser : NSObject {
    static let shared = APIParser()
    private var stations : [Station]
    private var station : Station!
    private var eName = ""
    
    private override init() {
        stations = [Station]()
        super.init()
    }
    
    func parseStationXML(_ xml : Data) -> [Station]? {

        let parse = XMLParser(data: xml)
        parse.delegate = self
        parse.parse()
        
        if parse.parserError == nil {
            return stations
        } else {
            return nil
        }
    }
}

extension APIParser : XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        eName = elementName
        
        if eName == "objStationData" {
            stations.append(station)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        
        if eName == "objStationData" {
            station = Station()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            if eName == "Stationfullname" {
                station.stationFullName = data
            }
        }
    }
}
