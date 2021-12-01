//
//  FavoriteEntity.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 18/11/21.
//

import Foundation
import RealmSwift

public class FavoriteEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
