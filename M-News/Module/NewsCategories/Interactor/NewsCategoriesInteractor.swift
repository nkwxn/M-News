//
//  NewsCategoriesInteractor.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation

final class NewsCategoriesInteractor: NewsCategoriesPresenterToInteractorProtocol {
    var presenter: NewsCategoriesInteractorToPresenterProtocol?
    
    func fetchCategories() {
        presenter?.newsCategoryFetched(categories: NewsCategory.allCases)
    }
}
