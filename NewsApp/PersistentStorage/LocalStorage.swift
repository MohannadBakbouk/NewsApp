//
//  LocalStorage.swift
//  NewsApp
//
//  Created by Mohannad on 2/7/22.
//

import RealmSwift
class LocalStorage : LocalStorageProtocol {
    
    fileprivate var realm : Realm? {
        do {
           return  try Realm()
        }
        catch (let ex) {
            debugPrint(ex)
            return nil
        }
    }
    
    func object<T>() -> T? where T : Object {
        let key: AnyObject = 0 as AnyObject
        return self.object(key: key)
    }
    
    func object<T>(key: Any?) -> T? where T : Object {
        guard let realm: Realm = self.realm  , let key: Any = key  else { return nil }
        guard let object = realm.object(ofType: T.self, forPrimaryKey: key)  else { return nil }
        return !object.isInvalidated ? object : nil
    }
    
    func object<T>(_ predicate: (T) -> Bool) -> T? where T : Object {
        guard let realm: Realm = self.realm else { return nil }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated }).first
    }
    
    func objects<T>() -> [T] where T : Object {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter({ !$0.isInvalidated })
    }
    
    func objects<T>(_ predicate: (T) -> Bool) -> [T] where T : Object {
        guard let realm: Realm = self.realm else { return [] }
        return realm.objects(T.self).filter(predicate).filter({ !$0.isInvalidated })
    }
    
    func write<T>(_ object: T?) -> Bool where T : Object {
        guard  let realm: Realm = self.realm ,
               let object: T = object , !object.isInvalidated  else { return false }
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
            return true
        } catch let error {
            print("Writing failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func write<T>(_ objects: [T]?) -> Bool where T : Object {
        guard  let realm: Realm = self.realm ,
               let objects : [T] = objects else { return false }
        let validated: [T] = objects.filter({ !$0.isInvalidated })
        do {
             try realm.write {
                print(validated.count)
                realm.add(validated, update: .all)
            }
            return true
        } catch let error {
            print("Writing failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func update(_ block: () -> ()) -> Bool {
        guard let realm: Realm = self.realm else { return false }
        do {
            try realm.write(block)
            return true
        } catch let error {
            print("Updating failed with error ", error)
        }
        return false
    }
    
    func delete<T>(_ object: T) -> Bool where T : Object {
        guard let realm: Realm = self.realm else { return false }
        guard !object.isInvalidated else { return true }
        do {
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            print("Deleting of item failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func delete<T>(_ objects: [T]) -> Bool where T : Object {
        guard let realm: Realm = self.realm else { return false }

        do {
            try realm.write {
                realm.delete(objects)
            }
            return true
        } catch let error {
            print("Deleting of array failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    func deleteAll<T>(_ object: T.Type) -> Bool where T : Object {
        guard let realm: Realm = self.realm else { return false }
        do {
            try realm.write {
                let target = realm.objects(object)
                print(target.count)
                realm.delete(target)

            }
            return true
        } catch let error {
            print("Deleting failed for ", String(describing: T.self), " with error ", error)
        }
        return false
    }
    
    
    
    
}
