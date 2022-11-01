//
//  CommitTableViewCellViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 01/11/22.
//

import UIKit

class CommitTableViewCellViewModel: NSObject {
    private var apiService: APIService!
    private(set) var commitsData: [Result]! {
        didSet {
            self.bindViewModelToViewController()
        }
    }
    var bindViewModelToViewController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    convenience init(repoName: String) {
        self.init()
        self.apiService = APIService()
        getRepoData(repoName: repoName)
    }
    
    func getRepoData(repoName: String) {
        self.apiService.getCommits(repoName: repoName) { data in
            self.commitsData = data
        }
    }
    
    func configureCell(cellToConfigure: CommitTableViewCell, data: Commit) {
        cellToConfigure.messageLabel.text = "\(data.message)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: data.author.date)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let printDate = dateFormatter.string(from: date ?? Date())
        
        cellToConfigure.authorLabel.text = "\(data.author.name) committed on \(printDate)"
    }
}
