//
//  Post.swift
//  Vipspad
//
//  Created by Azure on 8/1/23.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let discordURL: String
    let imageURL: String
    let image2URL: String
    let marketURL: String
    let creatorID: Int
    let categoryID: Int
    let networkID: Int
    let riskID: Int
    let createdAt: String
    let creator: BaseProp
    let network: BaseProp
    let riskIndex: BaseProp
    let category: BaseProp

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case discordURL = "discord_url"
        case imageURL = "image_url"
        case image2URL = "image2_url"
        case marketURL = "market_url"
        case creatorID = "creator_id"
        case categoryID = "category_id"
        case networkID = "network_id"
        case riskID = "risk_id"
        case createdAt = "created_at"
        case creator
        case network
        case riskIndex = "risk_index"
        case category
    }
}

typealias Posts = [Post]
