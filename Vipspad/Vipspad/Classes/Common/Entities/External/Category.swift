//
//  Category.swift
//  Vipspad
//
//  Created by Azure on 8/1/23.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
    let riskIndex: BaseProp
    let network: BaseProp
    let created_at: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, created_at
        case network = "network"
        case riskIndex = "risk_index"
    }
}

typealias Categories = [Category]
