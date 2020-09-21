//
//  AnswerPresenter.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 19.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

protocol AnswerPresenterOutput: class {
    func reloadData()
    func showEmptyContent()
    func setActivityState(isOn: Bool)
}

final class AnswerPresenter: NSObject {
    
    private var dataSource: AnswerItem?
    
    unowned var delegate: AnswerPresenterOutput!
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
        let cell = AnswerCell()
        cell.answer = dataSource?.items?[indexPath.row]
        return cell.height
    }
}

extension AnswerPresenter {
    
    func fetch(with questionID: String) {
        delegate.setActivityState(isOn: true)
        let query = Query(page: 1, pageSize: 25, sort: .answers(item: .activity), questionID: questionID)
        NetworkService<AnswerItem>().fetch(with: .answers, and: query) { [unowned self] (data, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataSource = data
                self.delegate.reloadData()
                self.delegate.setActivityState(isOn: false)
                if self.dataSource?.items?.isEmpty ?? true {
                    self.delegate.showEmptyContent()
                }
            }
        }
    }
}

