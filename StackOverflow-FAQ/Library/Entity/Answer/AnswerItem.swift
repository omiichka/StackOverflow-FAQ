//
//  AnswerItem.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

struct AnswerItem: ItemProtocol {
    typealias Element = Answer
    var items: [Answer]?
}

