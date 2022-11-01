//
//  CommitsViewController.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

class CommitsViewController: UIViewController {
    
    var repoName: String?
    let tableView: UITableView = {
        let table = UITableView()
        table.register(CommitTableViewCell.self, forCellReuseIdentifier: CommitTableViewCell.identifier)
        return table
    }()
    var commits = [Result]()
    private var viewModel: CommitTableViewCellViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Commits"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        fetchData()
    }
    
    func fetchData() {
        guard let repoName = repoName else { return }
        self.viewModel = CommitTableViewCellViewModel(repoName: repoName)
        self.viewModel.bindViewModelToViewController = {
            self.commits = self.viewModel.commitsData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension CommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableViewCell.identifier, for: indexPath) as! CommitTableViewCell
        let commit = commits[indexPath.row].commit
        self.viewModel.configureCell(cellToConfigure: cell, data: commit)
        return cell
    }
}
