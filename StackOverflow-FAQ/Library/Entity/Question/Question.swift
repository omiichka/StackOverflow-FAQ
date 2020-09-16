//
//  Question.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

struct Question: Decodable {
    var tags: [String]?
    var owner: Owner?
    var isAnswered: Bool?
    var viewCount: Int?
    var closedDate: Int?
    var answerCount: Int?
    var score: Int?
    var lastActivityDate: Int?
    var creationDate: Int?
    var lastEditDate: Int?
    var questionId: Int?
    var link: String?
    var closedReason: String?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case tags
        case owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case closedDate = "closed_date"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case questionId = "question_id"
        case link
        case closedReason = "closed_reason"
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tags = try? container.decode([String].self, forKey: .tags)
        owner = try? container.decode(Owner.self, forKey: .owner)
        isAnswered = try? container.decode(Bool.self, forKey: .isAnswered)
        viewCount = try? container.decode(Int.self, forKey: .viewCount)
        closedDate = try? container.decode(Int.self, forKey: .closedDate)
        answerCount = try? container.decode(Int.self, forKey: .answerCount)
        score = try? container.decode(Int.self, forKey: .score)
        lastActivityDate = try? container.decode(Int.self, forKey: .lastActivityDate)
        creationDate = try? container.decode(Int.self, forKey: .creationDate)
        lastEditDate = try? container.decode(Int.self, forKey: .lastEditDate)
        questionId = try? container.decode(Int.self, forKey: .questionId)
        link = try? container.decode(String.self, forKey: .link)
        closedReason = try? container.decode(String.self, forKey: .closedReason)
        title = try? container.decode(String.self, forKey: .title)
    }
}

