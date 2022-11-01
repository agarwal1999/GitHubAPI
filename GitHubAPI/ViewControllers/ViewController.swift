//
//  ViewController.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

final class ViewController: UIViewController {
    var data = [Repository]()
    var tableView: UITableView = {
        let table = UITableView()
        table.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.identifier)
        return table
    }()
    private var viewModel: RepositoryTableViewCellViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        self.viewModel = RepositoryTableViewCellViewModel()
        self.viewModel.bindViewModelToViewController = {
            self.data = self.viewModel.repoData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as! RepoTableViewCell
        let repo = data[indexPath.row]
        viewModel.configureCell(cellToConfigure: cell, data: repo)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commitsVC = CommitsViewController()
        commitsVC.repoName = data[indexPath.row].name
        navigationController?.pushViewController(commitsVC, animated: true)
    }
}

