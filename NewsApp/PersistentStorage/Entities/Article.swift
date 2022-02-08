//
//  Article.swift
//  NewsApp
//
//  Created by Mohannad on 2/7/22.
//

import RealmSwift
class Article :  Object {
    @objc dynamic var title : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var summery : String = ""
    @objc dynamic var publication : String = ""
    @objc dynamic var img : String = ""
    @objc dynamic var id : String = ""
    override class func primaryKey() -> String{
        return "id"
    }
}

extension Article {
    convenience init(data : ArticleViewData) {
        self.init()
        self.title = data.title
        self.content = data.content
        self.summery = data.summery
        self.publication = data.publication
        self.img = data.img
        self.id = data.id
    }
}
