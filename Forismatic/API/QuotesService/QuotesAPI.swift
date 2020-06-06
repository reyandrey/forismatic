//
//  QuoteAPI.swift
//  Forismatic
//
//  Created by Andrey on 05.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

enum QuotesAPI: APIEndpoint {
    case randomQuote(key: Int)
    
    var path: String { "/" }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .randomQuote(let key):
            var items = QuotesAPI.defaultQueryItems
            items.append(URLQueryItem(name: "key", value: "\(key)"))
            return items
        }
    }
    
    private static var defaultQueryItems: [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "method", value: "getQuote"))
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        queryItems.append(URLQueryItem(name: "lang", value: "ru"))
        return queryItems
    }
}
