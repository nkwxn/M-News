//
//  NewsCategoriesRouter.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import UIKit

final class NewsCategoriesRouter: NewsCategoriesPresenterToRouterProtocol {
    static func createModule() -> NewsCategoriesTableViewController {
        let view = NewsCategoriesTableViewController()
        
        let presenter: NewsCategoriesViewToPresenterProtocol & NewsCategoriesInteractorToPresenterProtocol = NewsCategoriesPresenter()
        let interactor: NewsCategoriesPresenterToInteractorProtocol = NewsCategoriesInteractor()
        let router: NewsCategoriesPresenterToRouterProtocol = NewsCategoriesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToSourcesController(nav: UINavigationController, with category: NewsCategory) {
        let sourcesModule = NewsSourcesRouter.createModule(with: category)
        nav.pushViewController(sourcesModule, animated: true)
    }
}
