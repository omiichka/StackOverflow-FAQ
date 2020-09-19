//
//  TableController.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

final class TableController<T: ItemProtocol>: UIViewController {
    
    private var contentView: TableView!
    private var presenter: TablePresenter<T>!
    private var isBarItemTouched = false
    private var offset: CGFloat = 0

    init(with type: CellType) {
        super.init(nibName: nil, bundle: nil)
        contentView = TableView(with: type)
        presenter = TablePresenter(with: type)
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
        if T.self == QuestionItem.self {
            setupNavigationBar(with: "Questions")
            setupNavigationItem()
            setupTagsController()
        }
        presenter.fetch()
    }
    
    @objc private func didHandleBarItem(_ sender: UIBarButtonItem) {
        isBarItemTouched = !isBarItemTouched
        guard let tagsTableController = children.first else { return }
        tagsTableController.view.frame = CGRect(x: -self.contentView.bounds.width / 2, y: offset + topbarHeight + 10, width: self.contentView.bounds.width / 2, height: contentView.bounds.height - topbarHeight - 10)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            tagsTableController.view.frame.origin.x = self.isBarItemTouched ? 0 : -self.view.bounds.width / 2
        })
    }
}

private extension TableController {
    
    func setup() {
        view.backgroundColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        presenter.delegate = self
        contentView.delegate = presenter
        contentView.dataSource = presenter
    }
    
    func setupNavigationBar(with title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.314, green: 0.89, blue: 0.761, alpha: 1)]
    }
    
    func setupNavigationItem() {
        let rightItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didHandleBarItem(_:)))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupTagsController() {
        let tagsTableController = TableController<TagItem>(with: .tags)
        tagsTableController.view.frame = CGRect(x: -contentView.bounds.width / 2, y: 0, width: contentView.bounds.width / 2, height: contentView.bounds.height - 100)
        tagsTableController.view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tagsTableController.view.layer.cornerRadius = 25
        tagsTableController.view.layer.borderWidth = 2
        tagsTableController.view.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        tagsTableController.view.frame = CGRect(x: -contentView.bounds.width / 2, y: 0, width: contentView.bounds.width / 2, height: contentView.bounds.height - 100)
        addChild(tagsTableController)
        tagsTableController.didMove(toParent: self)
        view.addSubview(tagsTableController.view)
    }
}

extension TableController: TablePresenterOutput {
    
    func update(new query: Query) {
        
    }
    
    
    func updatePosY(with offset: CGFloat) {
        self.offset = offset
    }
    
    func hideSlideMenu() {
        guard let tagsTableController = children.first else { return }
        isBarItemTouched = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            tagsTableController.view.frame.origin.x = -self.view.bounds.width / 2
        })
    }
    
    func push(_ item: Question) {
        let detailController = DetailController(question: item)
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func reloadData() {
        contentView.reloadData()
    }
}
