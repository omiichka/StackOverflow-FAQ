//
//  Owner.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    var reputation: Int?
    var userId: Int?
    var userType: String?
    var acceptRate: Int?
    var profileImage: String?
    var displayName: String?
    var link: String?
    
     enum CodingKeys: String, CodingKey {
        case reputation
        case userId = "user_id"
        case userType = "user_type"
        case acceptRate = "accept_rate"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reputation = try container.decode(Int.self, forKey: .reputation)
        userId = try container.decode(Int.self, forKey: .userId)
        userType = try container.decode(String.self, forKey: .userType)
        acceptRate = try container.decode(Int.self, forKey: .acceptRate)
        profileImage = try container.decode(String.self, forKey: .profileImage)
        displayName = try container.decode(String.self, forKey: .displayName)
        link = try container.decode(String.self, forKey: .link)
    }
}
