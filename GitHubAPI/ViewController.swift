//
//  ViewController.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

class ViewController: UIViewController {
    var data = [Repository]()
    var apiService: APIService!
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        self.apiService = APIService()
        self.apiService.getAllRepos {[weak self] results in
            self?.data.append(contentsOf: results)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.identifier, for: indexPath) as! RepoTableViewCell
        let model = data[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commitsVC = CommitsViewController()
        self.apiService.getCommits(repoName: data[indexPath.row].name) {[weak commitsVC] commits in
            commitsVC?.commits.append(contentsOf: commits)
            DispatchQueue.main.async {
                commitsVC?.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(commitsVC, animated: true)
    }
}

