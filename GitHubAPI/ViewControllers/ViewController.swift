//
//  ViewController.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(RepoTableCell.self, forCellReuseIdentifier: RepoTableCell.identifier)
        return table
    }()
    private let viewModel: RepositoryViewModel = {
        let viewModel = RepositoryViewModel()
        return viewModel
    }()
    private lazy var userDetails: TitleView = {
        let view = TitleView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = userDetails
        title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.getData {
            DispatchQueue.main.async {[weak self] in
                let labelText = self?.viewModel.cellViewModels[0].loginUser
                let imageURL = self?.viewModel.cellViewModels[0].avatarURL
                self?.userDetails.setValues(labelText: labelText, imageURL: imageURL)
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableCell.identifier, for: indexPath) as! RepoTableCell
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cellViewModel.configure(cell: cell)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoName = viewModel.cellViewModels[indexPath.row].nameValue
        let commitsVC = CommitsViewController(repoName: repoName, viewModel: CommitsViewModel(repoName: repoName))
        navigationController?.pushViewController(commitsVC, animated: true)
    }
}

