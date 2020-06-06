//
//  RandomQuouteService.swift
//  Forismatic
//
//  Created by Andrey on 04.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation


class QuotesService<E: Environment>: APIService {
    static var serverURL: String { return E.serverURL }
    static var defaultHTTPHeaders: [String : String] {
        var h = [String: String]()
        h["Accept"] = "application/json"
        h["Content-Type"] = "application/json"
        return h
    }
    
    private lazy var httpManager: HTTPRequestManager = { HTTPRequestManager(defaultHeaders: QuotesService.defaultHTTPHeaders) }()
    
    init() {}
    
    
    func getURL(for endpoint: APIEndpoint) throws -> URL {
        guard let url = URL(string: E.serverURL.appending(endpoint.path)) else { throw APIServiceError.invalidURLError }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = endpoint.queryItems
        if let components = components, let url = components.url { return url }
        else { throw APIServiceError.invalidURLError }
    }
}

extension QuotesService {
    func getRandomQuote(key: Int, completionHandler: @escaping ((Quote?) -> Void)) {
        let url = try! getURL(for: QuotesAPI.randomQuote(key: key))
        httpManager.sendRequest(.get, to: url, withPayload: nil) { (data, response, error) in
            completionHandler(try? JSONDecoder().decode(Quote.self, from: data ?? Data()))
        }
    }
}
