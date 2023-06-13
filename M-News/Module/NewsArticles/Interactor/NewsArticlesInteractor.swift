//
//  NewsArticlesInteractor.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation
import Alamofire

final class NewsArticlesInteractor: NewsArticlesPresenterToInteractorProtocol {
    var presenter: NewsArticlesInteractorToPresenterProtocol?
    
    func fetchArticles(withSource: NewsSource?, andCategory: NewsCategory, page: Int, searchQuery: String) {
        let params: [String: Any] = [
            "sources": withSource?.id ?? "",
            "q": searchQuery,
            "page": page
        ]
        
        AF.request("\(APIConstants.baseUrl)\(APIConstants.Endpoints.topHeadlines)", parameters: params, headers: APIConstants.header).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(NewsArticleResponse.self, from: data)
                    self?.presenter?.newsArticlesFetchSuccess(articles: decoded.articles)
                } catch {
                    self?.presenter?.newsArticlesFetchFailed(error: error)
                }
            case .failure(let error):
                self?.presenter?.newsArticlesFetchFailed(error: error)
            }
        }
    }
    
    
}
