//
//  RepositoryViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

class RepositoryViewModel: NSObject {
    var cellViewModels: [RepoTableCellViewModel]
    var apiService: APIService
    
    override init() {
        self.cellViewModels = [RepoTableCellViewModel]()
        self.apiService = APIService()
    }
    func getData(completion: @escaping () -> ()) {
        self.apiService.getAllRepos {[weak self] repoData in
            for datum in repoData {
                let cellViewModel = RepoTableCellViewModel(repoData: datum)
                self?.cellViewModels.append(cellViewModel)
                completion()
            }
        }
    }
}
