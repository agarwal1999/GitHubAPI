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
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.isHidden = true
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    private var viewModel: RepositoryViewModel = {
        let viewModel = RepositoryViewModel()
        return viewModel
    }()
    private lazy var userDetails: TitleView = {
        let view = TitleView()
        return view
    }()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemCyan
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        return refreshControl
    }()
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        viewModel.delegate = self
        viewModel.getData()
    }
    
    func commonInit() {
        configureUserDetails()
        configureTableView()
        configureIndicatorView()
    }
    
    func configureUserDetails() {
        view.addSubview(userDetails)
        userDetails.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            userDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userDetails.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userDetails.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
    }
    
    func configureIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    func configureErrorView() {
        view.addSubview(errorView)
        errorView.addErrorText(errorText: viewModel.error)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func refreshView() {
        viewModel.getData()
        self.refreshControl.endRefreshing()
    }
}

extension ViewController: RepositoryDelegate {
    
    func loadingData() {
        activityIndicatorView.startAnimating()
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    func handleError() {
        DispatchQueue.main.async { [weak self] in
            self?.configureErrorView()
            self?.activityIndicatorView.stopAnimating()
            self?.tableView.isHidden = true
            self?.userDetails.isHidden = true
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableCell.identifier, for: indexPath) as? RepoTableCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.getCellViewModel(index: indexPath.row)
        cellViewModel.configure(cell: cell)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repoName = viewModel.getCellViewModel(index: indexPath.row).repository?.name else {
            return
        }
        let commitsVC = CommitsViewController(repoName: repoName, viewModel: CommitsViewModel(repoName: repoName))
        navigationController?.pushViewController(commitsVC, animated: true)
    }
}

