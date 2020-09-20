//
//  AnswerPresenter.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

protocol BasePresenterOutput: class {
    func reloadData(for table: CellType?)
}

//extension BasePresenterOutput {
//    func reloadData(for table: CellType? = nil) {}
//}

//protocol AnswerPresenterOutput: class {
//    func reloadData()
//}

final class AnswerPresenter: NSObject {

    private var dataSource: AnswerItem?

    unowned var delegate: BasePresenterOutput!
}

extension AnswerPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String().cellIdentifier(type: .answers)) as! AnswerCell
        cell.answer = dataSource?.items?[indexPath.row]
        return cell
    }
}

extension AnswerPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension AnswerPresenter {

    func fetch(with questionID: String) {
        let query = Query(page: 1, pageSize: 25, sort: .answers(item: .activity), questionID: questionID)
        NetworkService<AnswerItem>().fetch(with: .answers, and: query) { [unowned self] (data, error) in
             guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataSource = data
                self.delegate.reloadData(for: .answers)
            }
        }
    }
}

