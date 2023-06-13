//
//  NewsCategoriesPresenter.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import UIKit

final class NewsCategoriesPresenter: NewsCategoriesViewToPresenterProtocol {
    var view: NewsCategoriesPresenterToViewProtocol?
    var interactor: NewsCategoriesPresenterToInteractorProtocol?
    var router: NewsCategoriesPresenterToRouterProtocol?
    
    func startFetchingCategories() {
        interactor?.fetchCategories()
    }
    
    func showNewsSourcesController(nav: UINavigationController, withCategory: NewsCategory) {
        router?.pushToSourcesController(nav: nav, with: withCategory)
    }
}

extension NewsCategoriesPresenter: NewsCategoriesInteractorToPresenterProtocol {
    func newsCategoryFetched(categories: [NewsCategory]) {
        view?.onNewsCategoryFetched(categories: categories)
    }
}
