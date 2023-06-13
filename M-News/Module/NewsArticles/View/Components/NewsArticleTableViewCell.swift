//
//  NewsArticleTableViewCell.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import UIKit
import AlamofireImage

final class NewsArticleTableViewCell: UITableViewCell {
    static let identifier = "NewsArticleTableViewCell"
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func configure(with article: NewsArticle) {
        self.titleLabel.text = article.title ?? ""
        
        self.publishDateLabel.text = article.publishDate()
        if let author = article.author {
            self.authorLabel.text = "by \(author)"
        } else {
            self.authorLabel.isHidden = true
        }
        self.descLabel.text = article.description ?? ""
        
        if let imgUrlString = article.urlToImage,
           let imgUrl = URL(string: imgUrlString) {
            self.newsImageView.af.setImage(withURL: imgUrl)
        }
    }
}
