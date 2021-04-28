//
//  DetailPresenter.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
  
  private let useCase: DetailUseCase
  
  @Published var note: NoteModel
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMsg: String = ""
  @Published var title: String = String()
  @Published var desc: String = String()
  @Published var disableButton = true
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(useCase: DetailUseCase, note: NoteModel) {
    self.useCase = useCase
    self.note = note
    
    $title
      .debounce(for: .zero, scheduler: RunLoop.main)
      .removeDuplicates()
      .compactMap { $0 }
      .sink { _ in
      } receiveValue: { _ in
        self.check()
      }.store(in: &cancellables)
    
    $desc
      .debounce(for: .zero, scheduler: RunLoop.main)
      .removeDuplicates()
      .compactMap { $0 }
      .sink { _ in
      } receiveValue: { _ in
        self.check()
      }.store(in: &cancellables)
  }
  
  func check() {
    if title != note.title || desc != note.desc {
      disableButton = false
    } else {
      disableButton = true
    }
  }
  
  var newNote: NoteModel {
    if title != note.title {
      return NoteModel(id: note.id, title: title, desc: note.desc,
                       date: todaysDate, update: updateTime, timeInterval: String(Date().timeIntervalSince1970))
    } else if desc != note.desc {
      return NoteModel(id: note.id, title: note.title, desc: desc,
                       date: todaysDate, update: updateTime, timeInterval: String(Date().timeIntervalSince1970))
    } else {
      return NoteModel(id: note.id, title: note.title, desc: note.desc,
                       date: todaysDate, update: updateTime, timeInterval: String(Date().timeIntervalSince1970))
    }
    
  }
  
  func removeNote() {
    useCase.removeNote(id: note.id)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMsg = error.localizedDescription
          self.isError = true
          print("error remove: \(error.localizedDescription)")
        case .finished:
          print("delete note")
        }
      } receiveValue: { _ in
      }.store(in: &cancellables)
  }
  
  func updateNote() {
    self.note = self.newNote
    useCase.updateNote(note: note)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMsg = error.localizedDescription
          self.isError = true
        case .finished:
          print("update note")
        }
      } receiveValue: { _ in
      }.store(in: &cancellables)
  }
  
}
