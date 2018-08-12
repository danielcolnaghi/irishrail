//
//  APIRouter.swift
//  IrishRail
//
//  Created by Daniel Colnaghi on 11/08/2018.
//  Copyright © 2018 Daniel Colnaghi. All rights reserved.
//

import Foundation

enum APIRouter {
    
    case allStationsWithType(_: String)
    case stationsByName(_: String)
    
    private var baseURL: URL {
        switch self {
        case .allStationsWithType(let type):
            return URL(string: "\(K.APIServer.baseURL)?\(K.APIParameterKey.stationType)=\(type)")!
        case .stationsByName(let name):
            return URL(string: "\(K.APIServer.baseURL)?\(K.APIParameterKey.stationDesc)=\(name)&NumMins=10")!
        }
    }
    
    private var path: String {
        switch self {
        case .allStationsWithType:
            return "/getAllStationsXML_WithStationType"
        case .stationsByName:
            return "/getStationDataByNameXML"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = "get"
                
        return urlRequest
    }
}
