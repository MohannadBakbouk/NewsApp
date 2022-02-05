//
//  SearchArticleResponse.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

struct SearchArticlesResponse : Codable {
    // MARK: - Proprties
    var status : String = ""
    var totalResults : Int = 0
    var articles : [ArticleSearchItem]
}
