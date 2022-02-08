//
//  LocalStorageProtocol.swift
//  NewsApp
//
//  Created by Mohannad on 2/7/22.
//

import RealmSwift

protocol LocalStorageProtocol {
    
    func object<T: Object>() -> T?
    func object<T: Object>( key : Any?) -> T?
    func object<T: Object>(_ predicate : (T) -> Bool) -> T?
    
    func objects<T: Object>() -> [T]
    func objects<T: Object>(_ predicate : (T) -> Bool) -> [T]
    
    @discardableResult func write<T: Object>(_ object : T?) -> Bool
    @discardableResult func write<T: Object>(_ objects : [T]?) -> Bool
    
    @discardableResult func update(_ block: () -> ()) -> Bool
    @discardableResult func delete<T: Object>(_ object: T) -> Bool
    @discardableResult func delete<T: Object>(_ objects: [T]) -> Bool
    @discardableResult func deleteAll<T: Object>(_ object: T.Type) -> Bool

    
}
