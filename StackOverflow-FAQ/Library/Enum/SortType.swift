//
//  SortType.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

enum SortType {
    
    case tags(item: SortTags)
    case questions(item: SortQuestions)
    case answers(item: SortAnswers)
    
    var value: String {
        switch self {
        case .tags(item: let item):
            return item.rawValue
        case .questions(item: let item):
            return item.rawValue
        case .answers(item: let item):
            return item.rawValue
        }
    }
}
