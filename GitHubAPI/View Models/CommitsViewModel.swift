//
//  CommitsViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

protocol CommitsDelegate: AnyObject {
    
    func updateView()
    func handleError()
}

class CommitsViewModel: NSObject {
    
    weak var delegate: CommitsDelegate?
    var cellViewModels: [CommitTableCellViewModel]
    var error: String?
    private var apiService: APIService
    private let repoName: String
    
    init(repoName: String) {
        self.repoName = repoName
        self.cellViewModels = [CommitTableCellViewModel]()
        self.apiService = APIService()
    }
    
    func getData() {
        self.cellViewModels = []
        self.apiService.getCommits(repoName: self.repoName) { [weak self] response in
            switch response {
            case .success(let results):
                if results.count > 0 {
                    for result in results {
                        let cellViewModel = CommitTableCellViewModel(commitData: result.commit)
                        self?.cellViewModels.append(cellViewModel)
                    }
                    self?.delegate?.updateView()
                } else {
                    self?.error = "\(self?.repoName ?? "This repository") doesn't have any commits to show"
                    self?.delegate?.handleError()
                }
                break
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    self?.error = "The URL has some problem"
                case .commitsNotFound:
                    self?.error = "There is some issue with your internet connection"
                case .jsonError:
                    self?.error = "Please check your model"
                default:
                    break
                }
                self?.delegate?.handleError()
                break
            }
        }
    }
    
    func getCellViewModel(index: Int) -> CommitTableCellViewModel {
        if index >= cellViewModels.count {
            delegate?.handleError()
            return CommitTableCellViewModel()
        } else {
            return cellViewModels[index]
        }
    }
}
