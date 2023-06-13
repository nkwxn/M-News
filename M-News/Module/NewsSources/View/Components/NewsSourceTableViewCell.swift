//
//  NewsSourceTableViewCell.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import UIKit

class NewsSourceTableViewCell: UITableViewCell {
    static let identifier = "NewsSourceTableViewCell"

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    
    func configure(with source: NewsSource) {
        self.titleLabel.text = source.name
        self.urlLabel.text = source.url
        self.descLabel.text = source.description
    }
}
