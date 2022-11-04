// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct User: Codable {
    let login: String
    let avatarURL: String
    let name: String
    let company: String
    let blog: String
    let email, location: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case name, company, blog, location, email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        self.name = try container.decode(String.self, forKey: .name)
        self.blog = try container.decode(String.self, forKey: .blog)
        if let company = try container.decodeIfPresent(String.self, forKey: .company) {
            self.company = company
        } else {
            self.company = "N/A"
        }
        if let location = try container.decodeIfPresent(String.self, forKey: .location) {
            self.location = location
        } else {
            self.location = "N/A"
        }
        if let email = try container.decodeIfPresent(String.self, forKey: .email) {
            self.email = email
        } else {
            self.email = "N/A"
        }
    }
}
