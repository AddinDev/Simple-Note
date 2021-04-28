//
//  MainUseCase.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import Combine

protocol MainUseCase {
  func getNotes() -> AnyPublisher<[NoteModel], Error>
  func removeNote(id: String) -> AnyPublisher<Bool, Error>
}

class MainInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension MainInteractor: MainUseCase {
  
  func getNotes() -> AnyPublisher<[NoteModel], Error> {
    self.repository.getNotes()
  }
  
  func removeNote(id: String) -> AnyPublisher<Bool, Error> {
    self.repository.removeNote(id: id)
  }
  
}
