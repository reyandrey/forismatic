//
//  Quote.swift
//  Forismatic
//
//  Created by Andrey on 04.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    let id: String
    let quoteText: String
    let quoteAuthor: String?
    let senderName: String?
    let senderLink: String?
    let quoteLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case quoteText
        case quoteAuthor
        case senderName
        case senderLink
        case quoteLink
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        quoteText = try container.decodeIfPresent(String.self, forKey: .quoteText) ?? ""
        quoteAuthor = try container.decodeIfPresent(String.self, forKey: .quoteAuthor)
        senderName = try container.decodeIfPresent(String.self, forKey: .senderName)
        senderLink = try container.decodeIfPresent(String.self, forKey: .senderLink)
        quoteLink = try container.decodeIfPresent(String.self, forKey: .quoteLink)
    }
}

