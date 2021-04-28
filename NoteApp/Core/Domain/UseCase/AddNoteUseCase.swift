//
//  AddTaskUseCase.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import Combine

protocol AddNoteUseCase {
  func addNote(note: NoteModel) -> AnyPublisher<Bool, Error>
}

class AddNoteInteractor {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
}

extension AddNoteInteractor: AddNoteUseCase {
  
  func addNote(note: NoteModel) -> AnyPublisher<Bool, Error> {
    self.repository.addNote(note: note)
  }
  
}
