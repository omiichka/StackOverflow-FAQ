//
//  String.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 16.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

extension String {
    
    func cellIdentifier(type: CellType) -> String {
        switch type {
        case .tags:
            return "TagsCell"
        case .questions:
            return "QuestionsCell"
        case .answers:
            return "AnswersCell"
        }
    }
}
