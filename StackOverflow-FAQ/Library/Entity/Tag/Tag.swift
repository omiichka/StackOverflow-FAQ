//
//  Tag.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

struct Tag: Decodable {
    var hasSynonyms: Bool?
    var isModeratorOnly: Bool?
    var isRequired: Bool?
    var count: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case hasSynonyms = "has_synonyms"
        case isModeratorOnly = "is_moderator_only"
        case isRequired = "is_required"
        case count
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hasSynonyms = try container.decode(Bool.self, forKey: .hasSynonyms)
        isModeratorOnly = try container.decode(Bool.self, forKey: .isModeratorOnly)
        isRequired = try container.decode(Bool.self, forKey: .isRequired)
        count = try container.decode(Int.self, forKey: .count)
        name = try container.decode(String.self, forKey: .name)
    }
}
