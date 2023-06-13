//
//  NewsWebViewProtocols.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation
import UIKit

protocol NewsWebPresenterToRouterProtocol: AnyObject {
    static func createModule(with url: String) -> NewsWebViewController
}
