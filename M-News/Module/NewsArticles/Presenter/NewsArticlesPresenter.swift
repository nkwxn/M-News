//
//  NewsArticlesPresenter.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation
import UIKit

class NewsArticlesPresenter: NewsArticlesViewToPresenterProtocol {
    var view: NewsArticlesPresenterToViewProtocol?
    var interactor: NewsArticlesPresenterToInteractorProtocol?
    var router: NewsArticlesPresenterToRouterProtocol?
    
    func startFetchingArticles(withSource: NewsSource?, andCategory: NewsCategory, page: Int, searchQuery: String) {
        interactor?.fetchArticles(withSource: withSource, andCategory: andCategory, page: page, searchQuery: searchQuery)
    }
    
    func showWebViewController(nav: UINavigationController, urlString: String) {
        router?.pushToWebViewController(nav: nav, urlString: urlString)
    }
}

extension NewsArticlesPresenter: NewsArticlesInteractorToPresenterProtocol {
    func newsArticlesFetchSuccess(articles: [NewsArticle]) {
        view?.onNewsArticlesResponseSuccess(articles: articles)
    }
    
    func newsArticlesFetchFailed(error: Error) {
        view?.onNewsArticlesResponseFailed(error: error)
    }
}
