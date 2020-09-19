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
    
    func formatter(intDate: Int) -> String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: Double(intDate))
        dateFormatter.dateFormat = "HH:mm d-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func timeAgo(intDate: Int) -> String {
        let now = Date()
        let date = Date(timeIntervalSince1970: Double(intDate))
        let formatter = DateComponentsFormatter()
        let calendar = Calendar.current
        var components: DateComponents
        formatter.unitsStyle = .full
        components = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute, .second], from: date, to: now)
        if components.year! > 0 {
            formatter.allowedUnits = NSCalendar.Unit.year
        } else if components.month! > 0 {
            formatter.allowedUnits = .month
        } else if components.weekOfMonth! > 0 {
            formatter.allowedUnits = .weekOfMonth
        } else if components.day! > 0 {
            formatter.allowedUnits = .day
        } else if components.hour! > 0 {
            formatter.allowedUnits = .hour
        } else if components.minute! > 0 {
            formatter.allowedUnits = .minute
        } else {
            formatter.allowedUnits = .second
        }
        return "  \(formatter.string(from: components) ?? "") ago"
    }
}
