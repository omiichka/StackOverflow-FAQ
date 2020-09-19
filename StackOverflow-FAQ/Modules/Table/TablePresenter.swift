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
    func hideSlideMenu()
    func updatePosY(with offset: CGFloat)
    func update(new query: Query)
    func push(_ item: Question)
}

final class TablePresenter<T: ItemProtocol>: NSObject, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    private var dataSource: T?
    private let type: CellType
    private var query = Query.defaultItem
 
    
    unowned var delegate: TablePresenterOutput!

    init(with type: CellType) {
        self.type = type
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String().cellIdentifier(type: type), for: indexPath) as! TableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: String().cellIdentifier(type: type)) as! TableCell 
        cell.setup(type: type, dataSource: dataSource?.items?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .tags:
            guard let tag = dataSource?.items?[indexPath.row] as? Tag else { return }
            let query = Query(page: 1, pageSize: 25, toDate: Query.today(), maxCount: 100, sort: SortType.tags(item: .activity), tagged: tag.name ?? "")
            delegate.update(new: query)
        case .questions:
            guard let question = dataSource?.items?[indexPath.row] as? Question else { return }
            delegate.push(question)
        case .answers:
            break
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if type == .questions {
             delegate.hideSlideMenu()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if type == .questions {
            delegate.updatePosY(with: scrollView.contentOffset.y)
        }
    }
}

extension TablePresenter {
    
    func updateQuestions(with type: CellType) {
    
    }

    func fetch() {
        NetworkService<T>().fetch(with: type, and: query) { [unowned self] (data, error) in
             guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataSource = data
                self.delegate.reloadData()
            }
        }
    }
}

