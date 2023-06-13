//
//  NewsWebViewRouter.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation

class NewsWebViewRouter: NewsWebPresenterToRouterProtocol {
    static func createModule(with url: String) -> NewsWebViewController {
        let view = NewsWebViewController()
        view.urlString = url
        return view
    }
}
