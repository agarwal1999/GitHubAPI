//
//  CommitsViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

class CommitsViewModel: NSObject {
    var cellViewModels: [CommitTableCellViewModel]
    var apiService: APIService
    private var repoName: String
    init(repoName: String) {
        self.repoName = repoName
        self.cellViewModels = [CommitTableCellViewModel]()
        self.apiService = APIService()
    }
    func getData(completion: @escaping () -> ()) {
        self.apiService.getCommits(repoName: self.repoName) { results in
            for result in results {
                let cellViewModel = CommitTableCellViewModel(commitData: result.commit)
                self.cellViewModels.append(cellViewModel)
                completion()
            }
        }
    }
}
