//
//  NetworkService.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

final class NetworkService<T: Decodable> {
    
    private let key = "&key=lM9LUyJRJfggLpICzMz*OQ(("
    private let filter = "&filter=!9YdnSMKKT"
    private let basePath = "https://api.stackexchange.com/2.2/"
    
    func fetch(with type: CellType, and query: Query, completion: @escaping (_ items: T?, _ error: Error?) -> Void) {
        let URL = getURL(with: type, and: query)
        getData(urlString: URL) { (data, error) in
            guard let data = data, error == nil else {
                print("Failed to get data")
                return completion(nil, error)
            }
            self.decode(json: data, completion: { (users, error) in
                if let error = error {
                    print("Failed to convert data")
                    return completion(nil, error)
                }
                return completion(users, nil)
            })
        }
    }
    
    func getURL(with type: CellType, and query: Query) -> String {
        let tagged = type == .tags ? "" : query.tagged ?? ""
        let toDate = query.toDate != nil ? "&todate=\(query.toDate)" : ""
        let maxCount = query.maxCount != nil ? "&max=\(String(describing: query.maxCount))" : ""
        let questionID = query.questionID != nil ? "\(query.questionID!)/" : ""
        var URL = String()
        if type != .answers {
            URL = basePath + type.rawValue + "?" + "page=\(query.page)" + "&pagesize=\(query.pageSize)" + toDate + maxCount + "&order=desc" + "&sort=\(query.sort.value)" + "&tagged=\(tagged)" + "&site=stackoverflow" + key
        } else {
            URL = basePath + "questions/" + questionID + type.rawValue + "?" + "&order=desc" + "&sort=\(query.sort.value)" + "&site=stackoverflow"  + key + filter
        }
        return URL
    }
}

private extension NetworkService {
    
    func getData(urlString: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            NSLog("Error: Cannot create URL from string")
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        session.dataTask(with: urlRequest) { (data, _, error) in
            let dispatch = DispatchQueue(label: "Custom_Queue", qos: .userInitiated, attributes: .concurrent)
            dispatch.async {
                guard let data = data, error == nil else {
                    NSLog("Error: Data task is nil")
                     return completion(nil, error)
                }
                completion(data, nil)
            }
        }
        .resume()
    }
    
    func decode(json: Data, completion: @escaping (_ data: T?, _ error: Error?) -> Void) {
        do {
            let items = try JSONDecoder().decode(T.self, from: json)
            return completion(items, nil)
        }
        catch {
            NSLog("Error: creating objects from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
}
