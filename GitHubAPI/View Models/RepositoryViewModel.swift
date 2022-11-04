//
//  RepositoryViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

protocol RepositoryDelegate: AnyObject {
    func loadingData()
    func updateView()
    func handleError()
}

class RepositoryViewModel: NSObject {
    
    weak var delegate: RepositoryDelegate?
    var cellViewModels: [RepoTableCellViewModel]
    var error: String?
    private let apiService: APIService
    
    override init() {
        self.cellViewModels = [RepoTableCellViewModel]()
        self.apiService = APIService()
    }
    
    func getData() {
        self.cellViewModels = []
        self.delegate?.loadingData()
        self.apiService.getAllRepos { [weak self] response in
            switch response {
            case .success(let repoData):
                if repoData.count > 0 {
                    for datum in repoData {
                        let cellViewModel = RepoTableCellViewModel(repoData: datum)
                        self?.cellViewModels.append(cellViewModel)
                    }
                    self?.delegate?.updateView()
                } else {
                    self?.error = "This user doesn't have any repositories to show"
                    self?.delegate?.handleError()
                }
                break
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    self?.error = "The URL has some problem"
                case .repoNotFound:
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
    
    func getCellViewModel(index: Int) -> RepoTableCellViewModel {
        if index >= cellViewModels.count {
            delegate?.handleError()
            return RepoTableCellViewModel()
        } else {
            return cellViewModels[index]
        }
    }
}
