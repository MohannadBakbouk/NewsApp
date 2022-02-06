//
//  ArticleViewData.swift
//  NewsApp
//
//  Created by Mohannad on 2/5/22.
//

struct ArticleViewData {
    var title : String
    var content : String
    var summery : String
    var publication : String
    var img : String
    
    init(data : ArticleSearchItem) {
        self.title = data.title
        self.content = data.content
        self.summery = data.description
        self.publication = data.source.name
        self.img = data.urlToImage
        
    }
}
