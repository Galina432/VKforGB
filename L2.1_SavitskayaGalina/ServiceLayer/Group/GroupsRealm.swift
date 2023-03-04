//
//  GroupsRealm.swift
//  L2.1_SavitskayaGalina
//
//  Created by Galina on 18.08.2022.
//

import Foundation
import RealmSwift

class GroupsRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var screenName: String
    @Persisted var photo50: String
}
