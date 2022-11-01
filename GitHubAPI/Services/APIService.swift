//
//  APIService.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import Foundation

class APIService {
    var repoData = [Repository]()
    let staticURL = "https://api.github.com/"
    
    func getAllRepos(completion: @escaping ([Repository]) -> ()) {
        guard let url = URL(string: staticURL + "users/saurabhmxp/repos") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                let results = try! JSONDecoder().decode([Repository].self, from: data)
                completion(results)
            }
        }.resume()
    }
    
    func getCommits(repoName: String, completion: @escaping ([Result]) -> ()) {
        guard let url = URL(string: staticURL + "repos/saurabhmxp/\(repoName)/commits") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                let results = try! JSONDecoder().decode([Result].self, from: data)
                completion(results)
            }
        }.resume()
    }
}
