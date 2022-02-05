//
//  ArticleSearchItem.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//
struct ArticleSearchItem : Codable {
  // MARK: - Proprties
    var author : String?
    var title : String
    var description : String
    var url : String
    var urlToImage : String
    var content : String
    var publishedAt : String
    var source : ArticleSearchItemSource
}
