//
//  APIService.swift
//  GitHubAPI
//
//  Created by Saurabh Agarwal on 31/10/22.
//

import Foundation

enum CustomError: Error {
    case userNotFound
    case repoNotFound
    case jsonError
    case invalidUrl
    case commitsNotFound
}

class APIService {
    let staticURL = "https://api.github.com/"
    
    func getUserDetails(completion: @escaping (Result<User, CustomError>) -> Void) {
        guard let url = URL(string: staticURL + "users/saurabhmxp/") else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.userNotFound))
                return
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.userNotFound))
                return
            }
            guard let data = data else {
                completion(.failure(.userNotFound))
                return
            }
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
                return
            } catch {
                completion(.failure(.jsonError))
                return
            }
        }
    }
    
    func getAllRepos(completion: @escaping (Result<[Repository], CustomError>) -> Void) {
        guard let url = URL(string: staticURL + "users/saurabhmxp/repos") else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.repoNotFound))
                return
            }
            do {
                let results = try JSONDecoder().decode([Repository].self, from: data)
                completion(.success(results))
                return
            } catch {
                completion(.failure(.jsonError))
                return
            }
        }.resume()
    }
    
    func getCommits(repoName: String, completion: @escaping (Result<[Response], CustomError>) -> ()) {
        guard let url = URL(string: staticURL + "repos/saurabhmxp/\(repoName)/commits") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.commitsNotFound))
                return
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.commitsNotFound))
                return
            }
            guard let data = data else {
                completion(.failure(.commitsNotFound))
                return
            }
            do {
                let results = try JSONDecoder().decode([Response].self, from: data)
                completion(.success(results))
                return
            } catch {
                completion(.failure(.jsonError))
                return
            }
                
        }.resume()
    }
}
