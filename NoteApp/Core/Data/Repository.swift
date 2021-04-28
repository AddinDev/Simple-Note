//
//  Repository.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import Combine

protocol RepositoryProtocol {
  func addNote(note: NoteModel) -> AnyPublisher<Bool, Error>
  func getNotes() -> AnyPublisher<[NoteModel], Error>
  func removeNote(id: String) -> AnyPublisher<Bool, Error>
  func updateNote(note: NoteModel) -> AnyPublisher<Bool, Error>
}

class Repository {
  
  typealias noteInstance = (LocaleDataSource) -> Repository
  
  private let locale: LocaleDataSource
  
  init(locale: LocaleDataSource) {
    self.locale = locale
  }
  
  static let sharedInstance: noteInstance = { locale in
      return Repository(locale: locale)
  }
  
}

extension Repository: RepositoryProtocol {
  
  func addNote(note: NoteModel) -> AnyPublisher<Bool, Error> {
    self.locale.addNote(note: NoteMapper.modelToEntity(note))
  }
  
  func getNotes() -> AnyPublisher<[NoteModel], Error> {
    self.locale.getNotes()
      .map { NoteMapper.entityToModel($0) }
      .eraseToAnyPublisher()
  }
  
  func removeNote(id: String) -> AnyPublisher<Bool, Error> {
    self.locale.removeNote(id: id)
  }
  
  func updateNote(note: NoteModel) -> AnyPublisher<Bool, Error> {
    self.locale.updateNote(note: NoteMapper.modelToEntity(note))
  }
  
}
