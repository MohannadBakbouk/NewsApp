//
//  ArticleViewData.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//
import Foundation
struct ArticleViewData {
    var title : String
    var content : String
    var summery : String
    var publication : String
    var img : String
    var id :String
    
    init(data : ArticleSearchItem) {
        self.title = data.title
        self.content = data.content
        self.summery = data.description
        self.publication = data.source.name
        self.img = data.urlToImage
        self.id = UUID().uuidString
    }
    
    init(stored : Article) {
        self.title = stored.title
        self.content = stored.content
        self.summery = stored.description
        self.publication = stored.publication
        self.img = stored.img
        self.id = stored.id
    }
}
