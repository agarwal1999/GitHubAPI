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
        viewModel.delegate = self
        viewModel.getData()
    }
}

extension CommitsViewController: CommitsDelegate {
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func handleError() {
        let ac = UIAlertController(title: "Error", message: viewModel.error, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            self?.viewModel.getData()
        }))
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            self?.present(ac, animated: true)
        }
    }
}

extension CommitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableCell.identifier, for: indexPath) as? CommitTableCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.getCellViewModel(index: indexPath.row)
        cellViewModel.configureCell(cell: cell)
        return cell
    }
}
