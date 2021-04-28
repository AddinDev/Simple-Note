//
//  LocaleDataSource.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol {
  func addNote(note: NoteEntity) -> AnyPublisher<Bool, Error>
  func getNotes() -> AnyPublisher<[NoteEntity], Error>
  func removeNote(id: String) -> AnyPublisher<Bool, Error>
  func updateNote(note: NoteEntity) -> AnyPublisher<Bool, Error>
}

class LocaleDataSource {
  
  private let realm: Realm?
  
  init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realm in
    return LocaleDataSource(realm: realm)
  }
  
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func addNote(note: NoteEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(note)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getNotes() -> AnyPublisher<[NoteEntity], Error> {
    return Future<[NoteEntity], Error> { completion in
      if let realm = self.realm {
        let notes: Results<NoteEntity> = {
          realm.objects(NoteEntity.self)
        }()
        completion(.success(notes.toArray(ofType: NoteEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func removeNote(id: String) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
          let notes: Results<NoteEntity> = {
            realm.objects(NoteEntity.self)
          }()
          guard let item = notes.first(where: { $0.id == id }) else { return }
        do {
          try realm.write {
            realm.delete(item)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func updateNote(note: NoteEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error>  { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.create(NoteEntity.self,
                         value: [
                          "id": note.id,
                          "title": note.title,
                          "desc": note.desc,
                          "date": note.date,
                          "update": note.update,
                          "timeInterval": note.timeInterval
                         ],
                         update: .modified)
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
