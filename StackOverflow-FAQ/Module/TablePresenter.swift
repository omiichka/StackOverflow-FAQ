//
//  TablePresenter.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

protocol TablePresenterOutput: class {
    func reloadData()
}

final class TablePresenter<T: ItemProtocol>: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var dataSource: T?
    private let type: CellType
    
    unowned var delegate: TablePresenterOutput!

    init(with type: CellType) {
        self.type = type
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String().cellIdentifier(type: type), for: indexPath) as? TableCell else {
            NSLog("Cant create cell") //?
            return UITableViewCell()
        }
        cell.setup(type: type, dataSource: dataSource?.items?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TablePresenter {

    func fetch() {
        NetworkService<T>().fetch(with: type, and: Query.defaultItem) { [unowned self] (data, error) in
             guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataSource = data
                self.delegate.reloadData()
            }
        }
    }
}

