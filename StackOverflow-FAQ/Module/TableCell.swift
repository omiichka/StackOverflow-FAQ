//
//  TableCell.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TableCell: UITableViewCell {
    
    func setup<T>(type: CellType, dataSource: T) {
        print(T.self, "DATASOURCE")
        switch type {
        case .tags:
            guard let dataSource = dataSource as? Tag else { return }
            setupTags(with: dataSource)
        case .questions:
            guard let dataSource = dataSource as? Question else { return }
            setupQuestions(with: dataSource)
        case .answers:
            guard let dataSource = dataSource as? Answer else { return }
            setupAnswers(with: dataSource)
        }
    }
}

private extension TableCell {
    
    func setupTags(with item: Tag) {
        let titleLabel = UILabel()
        titleLabel.text = item.name
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.frame = frame
        addSubview(titleLabel)
    }
    
    func setupQuestions(with item: Question) {
        let titleLabel = UILabel()
        let authorLabel = UILabel()
        let numberOfAnswerLabel = UILabel()
        let dateLabel = UILabel()
        
        titleLabel.text = item.title ?? ""
        authorLabel.text = item.owner?.displayName ?? ""
        numberOfAnswerLabel.text = "Answer: " + String(item.answerCount ?? 0)
        dateLabel.text = formatter(intDate: item.lastActivityDate ?? 0) + timeAgo(intDate: item.lastActivityDate ?? 0)
        
        [titleLabel, authorLabel, numberOfAnswerLabel, dateLabel].forEach {
            $0.font = .systemFont(ofSize: 13)
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        titleLabel.frame = CGRect(x: center.x - titleLabel.intrinsicContentSize.width / 2, y: 10, width: titleLabel.intrinsicContentSize.width, height: 20)
        authorLabel.frame = CGRect(x: 10, y: frame.height - 30, width: authorLabel.intrinsicContentSize.width, height: 20)
        numberOfAnswerLabel.frame = CGRect(x: frame.width - numberOfAnswerLabel.intrinsicContentSize.width - 10, y: titleLabel.frame.height + 30, width: numberOfAnswerLabel.intrinsicContentSize.width, height: 20)
        dateLabel.frame = CGRect(x: frame.width - dateLabel.intrinsicContentSize.width - 10, y: frame.height - 30, width: dateLabel.intrinsicContentSize.width, height: 20)
    }
    
    func setupAnswers(with item: Answer) {
        let answerLabel = UILabel()
        let authorLabel = UILabel()
        let lastActivityDateLabel = UILabel()
        let numberOfVotesLabel = UILabel()
        let checkImageView = UIImageView()
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
