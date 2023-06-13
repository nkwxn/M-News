//
//  NewsSourcesTableViewController.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import UIKit

class NewsSourcesTableViewController: UITableViewController {
    var presenter: NewsSourcesViewToPresenterProtocol?
    var category: NewsCategory = .generalNews
    private var sources: [NewsSource] = []
    
    private var searchQuery: String {
        return sourcesSearchController.searchBar.text ?? ""
    }
    
    private var filteredSources: [NewsSource] {
        if self.searchQuery.isEmpty {
            return sources
        } else {
            return sources.filter { source in
                source.name.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
    
    private lazy var sourcesSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search for News Sources"
        searchController.searchResultsUpdater = self
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
        self.title = category.rawValue.capitalized
        self.presenter?.startFetchingSources(withCategory: self.category)
        self.navigationItem.searchController = sourcesSearchController
        
        // Register Table View Cell
        self.tableView.register(UINib(nibName: NewsSourceTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsSourceTableViewCell.identifier)
        
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
        return filteredSources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = filteredSources[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsSourceTableViewCell.identifier, for: indexPath) as? NewsSourceTableViewCell
        cell?.configure(with: data)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nav = self.navigationController else { return }
        let sources = filteredSources[indexPath.row]
        self.presenter?.showNewsArticlesController(nav: nav, source: sources, category: category)
    }
}

extension NewsSourcesTableViewController: NewsSourcesPresenterToViewProtocol {
    func onNewsSourceResponseSuccess(sources: [NewsSource]) {
        self.sources = sources
        self.errorContainer.isHidden = true
        self.loader.isHidden = true
        self.tableView.reloadData()
    }
    
    func onNewsSourceResponseFailed(error: Error) {
        self.sources = []
        self.loader.isHidden = true
        self.errorContainer.isHidden = false
        self.errorContainer.configure(error: error)
    }
}

extension NewsSourcesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.reloadData()
    }
}
