//
//  Answer.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

struct Answer: Decodable {
    var owner: Owner?
    var isAccepted: Bool?
    var score: Int?
    var lastActivityDate: Int?
    var creationDate: Int?
    var answerId: Int?
    var questionId: Int?
    var contentLicense: String?
    
    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case answerId = "answer_id"
        case questionId = "question_id"
        case contentLicense = "content_license"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        owner = try container.decode(Owner.self, forKey: .owner)
        isAccepted = try container.decode(Bool.self, forKey: .isAccepted)
        score = try container.decode(Int.self, forKey: .score)
        lastActivityDate = try container.decode(Int.self, forKey: .lastActivityDate)
        creationDate = try container.decode(Int.self, forKey: .creationDate)
        answerId = try container.decode(Int.self, forKey: .answerId)
        questionId = try container.decode(Int.self, forKey: .questionId)
        contentLicense = try container.decode(String.self, forKey: .contentLicense)
    }
}
