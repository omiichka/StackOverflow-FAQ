//
//  Query.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

struct Query {
    let page: Int
    let pageSize: Int
    let toDate: Int
    let maxCount: Int
    let sort: SortType
    var tagged: String? = nil
    
    static let defaultItem = Query(page: 1, pageSize: 25, toDate: today(), maxCount: 999, sort: SortType.questions(item: .activity))
    static let defaultTaggedItem = Query(page: 1, pageSize: 25, toDate: today(), maxCount: 999, sort: SortType.questions(item: .activity), tagged: "iOS")
    
    static func today() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}
