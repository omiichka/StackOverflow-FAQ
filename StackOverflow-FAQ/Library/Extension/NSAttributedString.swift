//
//  NSAttributedString.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func setupAnswersBody(with body: String?) -> NSAttributedString {
        var answerBody = body
        let attributedString = NSMutableAttributedString(string: body ?? "")
        let regex = try? NSRegularExpression(pattern: "<code>[^>]+</code>", options: .caseInsensitive)
        let matches = regex?.matches(in: answerBody ?? "", options: [], range: NSRange(location: 0, length: answerBody?.count ?? 0))
        (matches ?? []).forEach {
            guard let value = UIFont(name: "Courier", size: 17) else { return }
                attributedString.addAttribute(.font, value: value, range: $0.range)
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
