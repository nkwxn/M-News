//
//  NewsSourcesModel.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation

struct NewsSourceResponse: Codable {
    var status: String
    var sources: [NewsSource]
}

struct NewsSource: Codable {
    var id: String
    let name: String
    let description: String
    let url: String
}
