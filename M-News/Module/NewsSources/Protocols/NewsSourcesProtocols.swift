//
//  NewsSourcesProtocols.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import UIKit

protocol NewsSourcesViewToPresenterProtocol: AnyObject {
    var view: NewsSourcesPresenterToViewProtocol? { get set }
    var interactor: NewsSourcesPresenterToInteractorProtocol? { get set }
    var router: NewsSourcesPresenterToRouterProtocol? { get set }
    func startFetchingSources(withCategory: NewsCategory)
    func showNewsArticlesController(nav: UINavigationController, source: NewsSource, category: NewsCategory)
}

protocol NewsSourcesPresenterToViewProtocol: AnyObject {
    func onNewsSourceResponseSuccess(sources: [NewsSource])
    func onNewsSourceResponseFailed(error: Error)
}

protocol NewsSourcesPresenterToRouterProtocol: AnyObject {
    static func createModule(with category: NewsCategory) -> NewsSourcesTableViewController
    func pushToNewsArticlesController(nav: UINavigationController, source: NewsSource, category: NewsCategory)
}

protocol NewsSourcesPresenterToInteractorProtocol: AnyObject {
    var presenter: NewsSourcesInteractorToPresenterProtocol? { get set }
    func fetchSources(withCategory: NewsCategory)
}

protocol NewsSourcesInteractorToPresenterProtocol: AnyObject {
    func newsSourcesFetchSuccess(sources: [NewsSource])
    func newsSourcesFetchFailed(error: Error)
}
