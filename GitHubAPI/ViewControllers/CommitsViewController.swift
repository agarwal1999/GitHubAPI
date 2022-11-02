//
//  CommitsViewController.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import UIKit

class CommitsViewController: UIViewController {
    
    private var repoName: String
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CommitTableCell.self, forCellReuseIdentifier: CommitTableCell.identifier)
        return table
    }()
    private var viewModel: CommitsViewModel
    
    init(repoName: String, viewModel: CommitsViewModel) {
        self.repoName = repoName
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Commits"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        fetchData()
    }
    
    func fetchData() {
        viewModel.getData {
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension CommitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableCell.identifier, for: indexPath) as! CommitTableCell
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cellViewModel.configureCell(cell: cell)
        return cell
    }
}
