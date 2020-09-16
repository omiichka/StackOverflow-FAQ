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
        presenter.fetch()
    }
}

private extension TableController {
    
    func setup() {
        presenter.delegate = self
        contentView.delegate = presenter
        contentView.dataSource = presenter
    }
}

extension TableController: TablePresenterOutput {
    
    func reloadData() {
        contentView.reloadData()
    }
}
