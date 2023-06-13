//
//  NewsArticlesRouter.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation
import UIKit

class NewsArticlesRouter: NewsArticlesPresenterToRouterProtocol {
    static func createModule(with source: NewsSource, and category: NewsCategory) -> NewsArticlesTableViewController {
        let view = NewsArticlesTableViewController()
        
        let presenter: NewsArticlesViewToPresenterProtocol & NewsArticlesInteractorToPresenterProtocol = NewsArticlesPresenter()
        let interactor: NewsArticlesPresenterToInteractorProtocol = NewsArticlesInteractor()
        let router: NewsArticlesPresenterToRouterProtocol = NewsArticlesRouter()
        
        view.presenter = presenter
        view.category = category
        view.source = source
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToWebViewController(nav: UINavigationController, urlString: String) {
        let module = NewsWebViewRouter.createModule(with: urlString)
        nav.pushViewController(module, animated: true)
    }
}
