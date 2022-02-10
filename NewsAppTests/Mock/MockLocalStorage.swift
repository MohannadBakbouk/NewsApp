//
//  MockedObjects.swift
//  NewsAppTests
//
//  Created by Mohannad on 2/9/22.
//

import Foundation
import RealmSwift
@testable import NewsApp

class MockLocalStorage : LocalStorageProtocol {
    var artiles : [Article] = [Article]()
    func object<T>() -> T? where T : Object {
        return nil
    }
    
    func object<T>(key: Any?) -> T? where T : Object {
        return nil
    }
    
    func object<T>(_ predicate: (T) -> Bool) -> T? where T : Object {
        return nil
    }
    
    func objects<T>() -> [T] where T : Object {
        return artiles as! [T]
    }
    
    func objects<T>(_ predicate: (T) -> Bool) -> [T] where T : Object {
        return []
    }
    
    func write<T>(_ object: T?) -> Bool where T : Object {
        return false
    }
    
    func write<T>(_ objects: [T]?) -> Bool where T : Object {
        self.artiles = []
        self.artiles.append(contentsOf: objects as! [Article])
        return true
    }
    
    func update(_ block: () -> ()) -> Bool {
        return false
    }
    
    func delete<T>(_ object: T) -> Bool where T : Object {
        
        return false
    }
    
    func delete<T>(_ objects: [T]) -> Bool where T : Object {
        return false
    }
    
    func deleteAll<T>(_ object: T.Type) -> Bool where T : Object {
        artiles.removeAll()
        return true
    }
    
    
}


extension MockLocalStorage {
    
    func loadDummyJsonToDB(){
        
        guard let data = try? Data(contentsOf: Bundle.main.url(forResource: "MockedArticleResponse", withExtension: "json")!) ,
        
        let response =  try? JSONDecoder().decode(SearchArticlesResponse.self, from: data) else { return }
        
        let dummyArticles = response.articles.map{ArticleViewData(data: $0)}.map{Article(data: $0)}

        self.artiles.append(contentsOf: dummyArticles)
        
        
    }
}
