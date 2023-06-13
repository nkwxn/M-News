//
//  NewsSourcesRouter.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import UIKit

class NewsSourcesRouter: NewsSourcesPresenterToRouterProtocol {
    static func createModule(with category: NewsCategory) -> NewsSourcesTableViewController {
        let view = NewsSourcesTableViewController()
        
        let presenter: NewsSourcesViewToPresenterProtocol & NewsSourcesInteractorToPresenterProtocol = NewsSourcesPresenter()
        let interactor: NewsSourcesPresenterToInteractorProtocol = NewsSourcesInteractor()
        let router: NewsSourcesPresenterToRouterProtocol = NewsSourcesRouter()
        
        view.presenter = presenter
        view.category = category
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToNewsArticlesController(nav: UINavigationController, source: NewsSource, category: NewsCategory) {
        let module = NewsArticlesRouter.createModule(with: source, and: category)
        nav.pushViewController(module, animated: true)
    }
}
