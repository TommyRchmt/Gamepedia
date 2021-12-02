//
//  LocalDataSource.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 18/11/21.
//

import Foundation
import RealmSwift
import RxSwift

public protocol LocalDataSource {
    func getFavorite() -> Observable<[FavoriteEntity]>
    func addFavorite(from favorite: FavoriteEntity) -> Observable<Bool>
    func checkFavorite(of id: String) -> Observable<Bool>
    func deleteFavorite(of id: String) -> Observable<Bool>
}

public class LocalDataSourceImpl {
    var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch {
                //Handle Error
            }
            return self.realm
        }
    }
}

extension LocalDataSourceImpl: LocalDataSource {
    public func getFavorite() -> Observable<[FavoriteEntity]> {
        return Observable<[FavoriteEntity]>.create { observer in
            
            let favorites: Results<FavoriteEntity> = {
                self.realm.objects(FavoriteEntity.self)
            }()
            observer.onNext(favorites.toArray(ofType: FavoriteEntity.self))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func addFavorite(from favorite: FavoriteEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try self.realm.write {
                    self.realm.add(favorite)
                    observer.onNext(true)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }
            
            return Disposables.create()
        }
    }
    
    public func checkFavorite(of id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let isFavorite = self.realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id) != nil
            observer.onNext(isFavorite)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    public func deleteFavorite(of id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try self.realm.write {
                    let deletedData = self.realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id)
                    if deletedData != nil {
                        self.realm.delete(deletedData!)
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onError(DatabaseError.requestFailed)
                    }
                }
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }
            
            return Disposables.create()
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
