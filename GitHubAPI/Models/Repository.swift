//
//  Repositories.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import Foundation

struct Repository: Codable {
    let name: String
    let language: String
    let owner: Owner
}

struct Owner: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

