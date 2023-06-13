//
//  NewsCategoriesTableViewController.swift
//  M-News
//
//  Created by Nicholas Kwan on 12/06/23.
//

import UIKit

class NewsCategoriesTableViewController: UITableViewController {
    var presenter: NewsCategoriesViewToPresenterProtocol?
    var newsCategories: [NewsCategory] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.startFetchingCategories()
        self.title = "Categories"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        // Configure the cell...
        var config = cell.defaultContentConfiguration()
        config.text = newsCategories[indexPath.row].rawValue.capitalized
        cell.contentConfiguration = config

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = self.navigationController else { return }
        self.presenter?.showNewsSourcesController(nav: navController, withCategory: newsCategories[indexPath.row])
    }
}

extension NewsCategoriesTableViewController: NewsCategoriesPresenterToViewProtocol {
    func onNewsCategoryFetched(categories: [NewsCategory]) {
        self.newsCategories = categories
    }
}
