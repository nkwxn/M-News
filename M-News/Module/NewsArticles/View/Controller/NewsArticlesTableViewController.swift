//
//  NewsArticlesTableViewController.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import UIKit

class NewsArticlesTableViewController: UITableViewController {
    var presenter: NewsArticlesViewToPresenterProtocol?
    var source: NewsSource?
    var category: NewsCategory = .generalNews
    
    var articles: [NewsArticle] = []
    var page: Int = 0
    
    var searchText: String {
        return articleSearchController.searchBar.text ?? ""
    }
    
    private lazy var articleSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search for News Article"
        searchController.delegate = self
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        return loader
    }()
    
    private lazy var errorContainer: ErrorContainerView = {
        let container = ErrorContainerView()
        container.isHidden = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = source?.name ?? ""
        self.presenter?.startFetchingArticles(withSource: source, andCategory: category, page: page, searchQuery: searchText)
        self.navigationItem.searchController = articleSearchController
        
        // Register Table View Cell
        self.tableView.register(UINib(nibName: NewsArticleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsArticleTableViewCell.identifier)
        
        // Add error container and loader
        self.view.addSubview(errorContainer)
        self.view.addSubview(loader)
        errorContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        errorContainer.widthAnchor.constraint(equalToConstant: 300).isActive = true
        errorContainer.centerXAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        errorContainer.centerYAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 70).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 70).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleTableViewCell.identifier, for: indexPath) as? NewsArticleTableViewCell
        cell?.configure(with: article)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = articles[indexPath.row].url ?? ""
        guard let nav = self.navigationController else { return }
        self.presenter?.showWebViewController(nav: nav, urlString: urlString)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if (bottomEdge >= scrollView.contentSize.height) {
            self.presenter?.startFetchingArticles(withSource: source, andCategory: category, page: page, searchQuery: searchText)
        }
    }
}

extension NewsArticlesTableViewController: NewsArticlesPresenterToViewProtocol {
    func onNewsArticlesResponseSuccess(articles: [NewsArticle]) {
        self.articles.append(contentsOf: articles)
        self.errorContainer.isHidden = true
        self.loader.isHidden = true
        self.tableView.reloadData()
        page += 1
    }
    
    func onNewsArticlesResponseFailed(error: Error) {
        self.articles = []
        self.loader.isHidden = true
        self.errorContainer.isHidden = false
        self.errorContainer.configure(error: error)
    }
}

extension NewsArticlesTableViewController: UISearchControllerDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.articles = []
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Load search value for
        self.articles = []
        self.tableView.reloadData()
        loader.isHidden = false
        page = 0
        self.presenter?.startFetchingArticles(withSource: source, andCategory: category, page: page, searchQuery: searchText)
    }
}

extension NewsArticlesTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.articles = []
        self.tableView.reloadData()
        loader.isHidden = false
        page = 0
        self.presenter?.startFetchingArticles(withSource: source, andCategory: category, page: page, searchQuery: "")
    }
}
