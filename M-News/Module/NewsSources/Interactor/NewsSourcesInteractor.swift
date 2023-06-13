//
//  NewsSourcesInteractor.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import Foundation
import Alamofire

final class NewsSourcesInteractor: NewsSourcesPresenterToInteractorProtocol {
    var presenter: NewsSourcesInteractorToPresenterProtocol?
    
    func fetchSources(withCategory: NewsCategory) {
        let params = [
            "category": withCategory.rawValue
        ]
        
        AF.request("\(APIConstants.baseUrl)\(APIConstants.Endpoints.sources)", parameters: params, headers: APIConstants.header).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(NewsSourceResponse.self, from: data)
                    self?.presenter?.newsSourcesFetchSuccess(sources: decoded.sources)
                } catch {
                    self?.presenter?.newsSourcesFetchFailed(error: error)
                }
            case .failure(let error):
                self?.presenter?.newsSourcesFetchFailed(error: error)
            }
        }
    }
}
