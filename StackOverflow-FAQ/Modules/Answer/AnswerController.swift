//
//  AnswerController.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class AnswerController: UIViewController {
    
    private let contentView = AnswerView()
    private let presenter = AnswerPresenter()
    private let questionID: String
    
    init(questionID: String) {
        self.questionID = questionID
        super.init(nibName: nil, bundle: nil)
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
        presenter.fetch(with: questionID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

private extension AnswerController {
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        presenter.delegate = self
        contentView.delegate = presenter
        contentView.dataSource = presenter
    }
}

extension AnswerController: AnswerPresenterOutput {
    
    func setActivityState(isOn: Bool) {
        contentView.setActivityState(isOn: isOn)
    }
    
    func showEmptyContent() {
        contentView.showEmptyView()
    }
    
    func reloadData() {
        contentView.reloadData()
    }
}
