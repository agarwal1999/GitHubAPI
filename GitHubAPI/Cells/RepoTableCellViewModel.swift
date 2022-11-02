//
//  RepoTableCellViewModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 02/11/22.
//

import UIKit

class RepoTableCellViewModel: NSObject {
    private var name: String
    private var language: String
    var loginUser: String
    var avatarURL: String
    var nameValue: String{
        return name
    }
    
    init(repoData: Repository) {
        self.name = repoData.name
        self.language = repoData.language
        self.loginUser = repoData.owner.login
        self.avatarURL = repoData.owner.avatarURL
    }
    
    func configure(cell: RepoTableCell) {
        cell.repoNameLabel.text = self.name
        cell.langLabel.text = self.language
    }
}
