//
//  QuoteViewModel.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

class QuoteViewModel {
    
    let api = QuotesService<FSMEnvironment>()
    
    //MARK: - Lifeycle
    init() {}
    
    var didError: ((Error) -> Void)?
    var didUpdate: ((QuoteViewModel) -> Void)?
    
    private(set) var isUpdating: Bool = false { didSet { self.didUpdate?(self) } }
    
    //MARK: - Properties
   
    private var quote: Quote?
    
    var title: String {
        return isUpdating ? "Загрузка.." : "Случайная цитата"
    }
    
    var quoteText: String {
        quote?.quoteText ?? ""
    }
    
    var quoteAuthor: String {
        guard let author = quote?.quoteAuthor else { return "..." }
        return author.isEmpty ? "..." : author
    }
    
    //MARK: - Actions
    func reloadData() {
        self.isUpdating = true
        api.getRandomQuote(key: Int.random(in: 0...999999)) { [weak self] quote in
            DispatchQueue.main.async {
                self?.quote = quote
                self?.isUpdating = false
            }
        }
    }
 
}
