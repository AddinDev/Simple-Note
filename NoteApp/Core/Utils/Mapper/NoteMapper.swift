//
//  NoteMapper.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation

class NoteMapper {
  
  static func entityToModel(_ entities: [NoteEntity]) -> [NoteModel] {
    return entities.map { entity in
      return NoteModel(id: entity.id,
                       title: entity.title,
                       desc: entity.desc,
                       date: entity.date,
                       update: entity.update,
                       timeInterval: entity.timeInterval)
    }
  }
  
  static func modelToEntity(_ model: NoteModel) -> NoteEntity {
    let entity = NoteEntity()
    entity.id = model.id
    entity.title = model.title
    entity.desc = model.desc
    entity.date = model.date
    entity.update = model.update
    entity.timeInterval = model.timeInterval
    return entity
  }
  
}
