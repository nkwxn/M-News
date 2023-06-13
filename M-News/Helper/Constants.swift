//
//  Constants.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import Alamofire

struct APIConstants {
    static let baseUrl = "https://newsapi.org/v2"
    static let key = "490908210f304cc6b4dc2acd3bb3c99c"
    static let header: HTTPHeaders = HTTPHeaders([
        HTTPHeader(name: "X-Api-Key", value: APIConstants.key)
    ])
    
    struct Endpoints {
        static let topHeadlines = "/top-headlines"
        static let sources = "/top-headlines/sources"
    }
}
