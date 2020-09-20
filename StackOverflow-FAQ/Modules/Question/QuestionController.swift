//
//  QuestionController.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class QuestionController: UIViewController {
    
    private let contentView = QuestionView()
    private let tagsView = TagView()
    private let presenter = QuestionPresenter()
    private var isBarItemTouched = false
    private var offset: CGFloat = 0
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
        setupNavigationItem()
        setupTagsView()
        presenter.fetch(for: contentView)
    }
}

private extension QuestionController {
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        presenter.delegate = self
        contentView.delegate = presenter
        contentView.dataSource = presenter
    }
    
    func setupNavigationBar() {
        title = "Questions"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
    }
    
    func setupNavigationItem() {
        let rightItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didHandleBarItem(_:)))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupTagsView() {
        tagsView.delegate = presenter
        tagsView.dataSource = presenter
        tagsView.frame = CGRect(x: -contentView.bounds.width / 1.5, y: offset + topbarHeight + 10, width: contentView.bounds.width / 1.5, height: contentView.bounds.height - topbarHeight - 10)
        presenter.fetch(for: tagsView)
        view.addSubview(tagsView)
    }

    @objc func didHandleBarItem(_ sender: UIBarButtonItem) {
        isBarItemTouched = !isBarItemTouched
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.tagsView.frame = CGRect(x: self.isBarItemTouched ? 0 : -self.view.bounds.width / 1.5, y: self.offset + self.topbarHeight + 10, width: self.contentView.bounds.width / 1.5, height: self.contentView.bounds.height - self.topbarHeight - 10)
        })
    }
}

extension QuestionController: QuestionPresenterOutput {
    
    var currentView: QuestionView {
        return contentView
    }
    
    func updatePosY(with offset: CGFloat) {
        self.offset = offset
        tagsView.frame.origin.y = offset + topbarHeight + 10
    }
    
    func hideSlideMenu() {
        isBarItemTouched = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.tagsView.frame.origin.x = -self.view.bounds.width / 1.5
        })
    }
    
    func push(_ item: Question) {
        let detailController = DetailController(question: item)
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func reloadData(for table: CellType?) {
        guard let table = table else { return }
        switch table {
        case .tags:
            tagsView.reloadData()
        case .questions:
            contentView.reloadData()
        case .answers:
            break
        }
    }
}
