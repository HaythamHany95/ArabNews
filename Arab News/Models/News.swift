//
//  News.swift
//  Arab News
//
//  Created by Haytham on 23/09/2023.
//

import Foundation

struct News: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}


// MARK: - Article
struct Article: Decodable {
    let title: String?
    let url: String?
}
