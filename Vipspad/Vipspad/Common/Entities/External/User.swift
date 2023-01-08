//
//  User.swift
//  Vipspad
//
//  Created by Azure on 8/1/23.
//

import Foundation

// MARK: - NonRefsJSON
struct User: Codable {
    let id: Int
    let name, email, createdAt: String
    let photoURL: String
    let discordToken, discordRefreshToken: String
    let isAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case createdAt = "created_at"
        case photoURL = "photo_url"
        case discordToken = "discord_token"
        case discordRefreshToken = "discord_refresh_token"
        case isAdmin = "is_admin"
    }
}
