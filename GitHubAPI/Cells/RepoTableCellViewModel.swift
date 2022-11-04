//
//  RepoTableCellViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

class RepoTableCellViewModel: NSObject {
    private(set) var repository: Repository?
    
    override init() {
        self.repository = nil
    }
    
    init(repoData: Repository) {
        self.repository = repoData
    }
    
    func configure(cell: RepoTableCell) {
        cell.repoNameLabel.text = self.repository?.name
        cell.langLabel.text = self.repository?.language
    }
}
