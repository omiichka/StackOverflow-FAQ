//
//  NSAttributedString.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func setupAnswersBody(with answer: Answer) -> NSAttributedString {
        var answerBody = answer.body
        let attributedString = NSMutableAttributedString(string: answer.body ?? "")
        let pattern = "<code>[^>]+</code>"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let matches = regex?.matches(in: answerBody ?? "", options: [], range: NSRange(location: 0, length: answerBody?.count ?? 0))
        for match in matches ?? [] {
            attributedString.addAttribute(.backgroundColor, value: UIColor(red: 0, green: 110.0 / 255.0, blue: 200.0 / 255.0, alpha: 0.5), range: match.range)
            if let aSize = UIFont(name: "Courier", size: 17) {
                attributedString.addAttribute(.font, value: aSize, range: match.range)
            }
        }
        var cycle = true
        while cycle {
            if let aSearch = (answerBody as NSString?)?.range(of: "<[^>]+>", options: .regularExpression), aSearch.location != NSNotFound {
                attributedString.removeAttribute(.backgroundColor, range: aSearch)
                attributedString.replaceCharacters(in: aSearch, with: "\n")
                answerBody = (answerBody as NSString?)?.replacingCharacters(in: aSearch, with: "\n")
            } else {
                cycle = false
            }
        }
        return attributedString
    }
}
