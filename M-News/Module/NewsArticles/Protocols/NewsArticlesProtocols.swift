//
//  NewsArticlesProtocols.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation
import UIKit

protocol NewsArticlesViewToPresenterProtocol: AnyObject {
    var view: NewsArticlesPresenterToViewProtocol? { get set }
    var interactor: NewsArticlesPresenterToInteractorProtocol? { get set }
    var router: NewsArticlesPresenterToRouterProtocol? { get set }
    func startFetchingArticles(withSource: NewsSource?, andCategory: NewsCategory, page: Int, searchQuery: String)
    func showWebViewController(nav: UINavigationController, urlString: String)
}

protocol NewsArticlesPresenterToViewProtocol: AnyObject {
    func onNewsArticlesResponseSuccess(articles: [NewsArticle])
    func onNewsArticlesResponseFailed(error: Error)
}

protocol NewsArticlesPresenterToRouterProtocol: AnyObject {
    static func createModule(with source: NewsSource, and category: NewsCategory) -> NewsArticlesTableViewController
    func pushToWebViewController(nav: UINavigationController, urlString: String)
}

protocol NewsArticlesPresenterToInteractorProtocol: AnyObject {
    var presenter: NewsArticlesInteractorToPresenterProtocol? { get set }
    func fetchArticles(withSource: NewsSource?, andCategory: NewsCategory, page: Int, searchQuery: String)
}

protocol NewsArticlesInteractorToPresenterProtocol: AnyObject {
    func newsArticlesFetchSuccess(articles: [NewsArticle])
    func newsArticlesFetchFailed(error: Error)
}
