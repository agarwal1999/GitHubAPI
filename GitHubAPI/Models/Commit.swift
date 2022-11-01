//
//  CommitModel.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import Foundation


struct Result: Codable {
    let commit: Commit
}

struct Commit: Codable {
    let message: String
    let author: Author
}

struct Author: Codable {
    let name: String
    let date: String
}


