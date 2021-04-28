//
//  DetailUseCase.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import Combine

protocol DetailUseCase {
  func removeNote(id: String) -> AnyPublisher<Bool, Error>
  func updateNote(note: NoteModel) -> AnyPublisher<Bool, Error>
}

class DetailInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension DetailInteractor: DetailUseCase {
  
  func removeNote(id: String) -> AnyPublisher<Bool, Error> {
    self.repository.removeNote(id: id)
  }
  
  func updateNote(note: NoteModel) -> AnyPublisher<Bool, Error> {
    self.repository.updateNote(note: note)
  }
  
}
