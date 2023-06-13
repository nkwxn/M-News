//
//  NewsArticleEntity.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation

struct NewsArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}

struct NewsArticle: Codable {
    let title: String?
    let author: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    // yyyy-MM-ddTHH:mm:ssZ
    func publishDate() -> String {
        guard let publishedAt else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = formatter.date(from: publishedAt) ?? Date()
        let newFormat = DateFormatter()
        newFormat.dateStyle = .medium
        newFormat.timeStyle = .short
        return "Published at \(newFormat.string(from: date))"
    }
}
