//
//  QuestionPresenter.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import UIKit

protocol QuestionPresenterOutput: class {
    
    var currentView: QuestionView { get }
    
    func hideSlideMenu()
    func updatePosY(with offset: CGFloat)
    func push(_ item: Question)
    func reloadData(for table: CellType?)
    func setActivityState(isOn: Bool)
}

final class QuestionPresenter: NSObject {
    
    private var dataSource: QuestionItem?
    private var tagDataSource: TagItem?
    
    unowned var delegate: QuestionPresenterOutput!
}

extension QuestionPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if delegate.currentView == tableView {
            guard let question = dataSource?.items?[indexPath.row] else { return }
            delegate.push(question)
        } else {
            guard let tag = tagDataSource?.items?[indexPath.row] else { return }
            let query = Query(page: 1, pageSize: 25, sort: SortType.tags(item: .activity), tagged: tag.name ?? "")
            fetch(for: delegate.currentView, with: query)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate.currentView == tableView ? 150 : 50
    }
}

extension QuestionPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.currentView == tableView ? dataSource?.items?.count ?? 0 : tagDataSource?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if delegate.currentView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: String().cellIdentifier(type: .questions)) as! QuestionCell
            cell.question = dataSource?.items?[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String().cellIdentifier(type: .tags)) as! TagCell
            cell.tags = tagDataSource?.items?[indexPath.row]
            return cell
        }
    }
}

extension QuestionPresenter: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard (scrollView.subviews.first as? QuestionCell) != nil else { return }
        delegate.hideSlideMenu()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard (scrollView.subviews.first as? QuestionCell) != nil else { return }
        delegate.updatePosY(with: scrollView.contentOffset.y)
    }
}

extension QuestionPresenter {
    
    func fetch(for contentView: UIView, with query: Query? = nil) {
        self.delegate.setActivityState(isOn: true)
        if delegate.currentView === contentView {
            let query = query ?? Query.defaultTaggedItem
            NetworkService<QuestionItem>().fetch(with: .questions, and: query) { [unowned self] (data, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.dataSource = data
                    self.delegate.reloadData(for: .questions)
                    self.delegate.setActivityState(isOn: false)
                }
            }
        } else {
            let query = query ?? Query.defaultItem
            NetworkService<TagItem>().fetch(with: .tags, and: query) { [unowned self] (data, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.tagDataSource = data
                    self.delegate.reloadData(for: .tags)
                    self.delegate.setActivityState(isOn: false)
                }
            }
        }
    }
}

