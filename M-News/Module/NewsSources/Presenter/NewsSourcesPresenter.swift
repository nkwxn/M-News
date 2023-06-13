//
//  NewsSourcesPresenter.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import UIKit

final class NewsSourcesPresenter: NewsSourcesViewToPresenterProtocol {
    var view: NewsSourcesPresenterToViewProtocol?
    
    var interactor: NewsSourcesPresenterToInteractorProtocol?
    
    var router: NewsSourcesPresenterToRouterProtocol?
    
    func startFetchingSources(withCategory: NewsCategory) {
        interactor?.fetchSources(withCategory: withCategory)
    }
    
    func showNewsArticlesController(nav: UINavigationController, source: NewsSource, category: NewsCategory) {
        router?.pushToNewsArticlesController(nav: nav, source: source, category: category)
    }
}

extension NewsSourcesPresenter: NewsSourcesInteractorToPresenterProtocol {
    func newsSourcesFetchSuccess(sources: [NewsSource]) {
        view?.onNewsSourceResponseSuccess(sources: sources)
    }
    
    func newsSourcesFetchFailed(error: Error) {
        view?.onNewsSourceResponseFailed(error: error)
    }
}
