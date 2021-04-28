//
//  NoteEntity.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import RealmSwift

class NoteEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var date: String = ""
  @objc dynamic var update: String = ""
  @objc dynamic var timeInterval: String = ""

  override class func primaryKey() -> String? {
    return "id"
  }

}
