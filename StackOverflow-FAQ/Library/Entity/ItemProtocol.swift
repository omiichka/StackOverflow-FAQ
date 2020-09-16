//
//  ItemProtocol.swift
//  StackOverflow-FAQ
//
//  Created by Artem Golovanev on 15.09.2020.
//  Copyright © 2020 Artem Golovanev. All rights reserved.
//

import Foundation

protocol ItemProtocol: Decodable {
    associatedtype Element
    var items: [Element]? { get set }
}
