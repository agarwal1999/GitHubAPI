//
//  RepositoryTableViewCellViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 01/11/22.
//

import UIKit

class RepositoryTableViewCellViewModel: NSObject {
    private var apiService: APIService!
    private(set) var repoData: [Repository]! {
        didSet {
            self.bindViewModelToViewController()
        }
    }
    var bindViewModelToViewController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        getRepoData()
    }
    
    func getRepoData() {
        self.apiService.getAllRepos { data in
            self.repoData = data
        }
    }
    
    func configureCell(cellToConfigure: RepoTableViewCell, data: Repository) {
        cellToConfigure.repoNameLabel.text = "\(data.name)"
        cellToConfigure.langLabel.text = "\(data.language)"
    }
}
