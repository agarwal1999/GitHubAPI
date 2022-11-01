//
//  CommitsViewController.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

class CommitsViewController: UIViewController {
    
    var commits = [Result]()
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Commits"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}

extension CommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let commit = commits[indexPath.row].commit
        var content = cell.defaultContentConfiguration()
        content.text = "\(commit.message) and \(commit.author.name)"
        cell.contentConfiguration = content
        return cell
    }
}
