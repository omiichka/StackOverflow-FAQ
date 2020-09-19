//
//  DetailController.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 16.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class DetailController: UIViewController {
    
    private let contentView = DetailView()
//    private let question: Question
    
    init(question: Question) {
        print(question, "question")
        super.init(nibName: nil, bundle: nil)
        contentView.question = question
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension DetailController {
    
    func setup() {
        contentView.showAnswersButton.addTarget(self, action: #selector(didHandleShowAnswersButton(_:)), for: .touchUpInside)
    }
    
    @objc func didHandleShowAnswersButton(_ sender: UIButton) {
        let answerController = TableController<AnswerItem>(with: .answers)
        present(answerController, animated: true, completion: nil)
    }
}
