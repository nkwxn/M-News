//
//  NewsCategoriesProtocols.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import UIKit

protocol NewsCategoriesViewToPresenterProtocol: AnyObject {
    var view: NewsCategoriesPresenterToViewProtocol? { get set }
    var interactor: NewsCategoriesPresenterToInteractorProtocol? { get set }
    var router: NewsCategoriesPresenterToRouterProtocol? { get set }
    func startFetchingCategories()
    func showNewsSourcesController(nav: UINavigationController, withCategory: NewsCategory)
}

protocol NewsCategoriesPresenterToViewProtocol: AnyObject {
    func onNewsCategoryFetched(categories: [NewsCategory])
}

protocol NewsCategoriesPresenterToRouterProtocol: AnyObject {
    static func createModule() -> NewsCategoriesTableViewController
    func pushToSourcesController(nav: UINavigationController, with category: NewsCategory)
}

protocol NewsCategoriesPresenterToInteractorProtocol: AnyObject {
    var presenter: NewsCategoriesInteractorToPresenterProtocol? { get set }
    func fetchCategories()
}

protocol NewsCategoriesInteractorToPresenterProtocol: AnyObject {
    func newsCategoryFetched(categories: [NewsCategory])
}
