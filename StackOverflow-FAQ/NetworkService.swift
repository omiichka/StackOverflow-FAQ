//
//  NetworkService.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 14.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

final class NetworkService<T: Decodable> {
    
    private let clientSecret = "0jNwsPQ1hmNwKKg3T7ABhA(("
    private let key = "lM9LUyJRJfggLpICzMz*OQ(("
    private let basePath = "https://api.stackexchange.com/2.2/"
    
    
    func fetch(with type: CellType, and query: Query, completion: @escaping (_ items: T?, _ error: Error?) -> Void) {
        let tagged = type == .tags ? "" : query.tagged ?? ""
        
//        let URL = basePath + type.rawValue + "?" + clientSecret + key  + "page=\(query.page)" + "&pagesize=\(query.pageSize)" + "&todate=\(query.toDate)" + "&order=desc" + "&max=\(query.maxCount)" + "&sort=\(query.sort.value)" + "&tagged=\(tagged)" + "&site=stackoverflow"
        let URL = basePath + type.rawValue + "?" + clientSecret + key  + "page=\(query.page)" + "&pagesize=\(query.pageSize)" + "&todate=\(query.toDate)" + "&order=desc" + "&sort=\(query.sort.value)" + "&tagged=\(tagged)" + "&site=stackoverflow"

        print(URL, "URL")
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
            let decoder = JSONDecoder()
            print(T.self, "TTTTTTTTTTT")
            print(json, "json")
            let users = try decoder.decode(T.self, from: json)
            return completion(users, nil)
        }
        catch {
            NSLog("Error: creating objects from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
}

//https://api.stackexchange.com/2.2/questions?page=1&pagesize=25&order=desc&max=999&sort=questions(item: StackOverflow_FAQ.SortQuestions.activity)&tagged=&tagged=&site=stackoverflow
//
//https://api.stackexchange.com/2.2/questions?page=1&pagesize=10&order=desc&sort=votes&site=stackoverflow

