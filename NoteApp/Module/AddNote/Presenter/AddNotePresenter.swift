//
//  AddTaskPresenter.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import Combine

class AddNotePresenter: ObservableObject {
  
  private let useCase: AddNoteUseCase
  
  @Published var title: String = String()
  @Published var desc: String = String()

  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMsg: String = ""
  
  @Published var disableButton = true
  
  private var cancellables: Set<AnyCancellable> = []

  init(useCase: AddNoteUseCase) {
    self.useCase = useCase
    
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
    if title == "" || desc == "" {
      disableButton = true
    } else {
      disableButton = false
    }
  }
  
  func addNote() {
    isLoading = true
    useCase.addNote(note: NoteModel(id: UUID().uuidString, title: title, desc: desc,
                                    date: todaysDate, update: updateTime, timeInterval: String(Date().timeIntervalSince1970)))
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMsg = error.localizedDescription
          self.isLoading = false
          self.isError = true
        case .finished:
          self.isLoading = false
        }
      } receiveValue: { _ in
      }.store(in: &cancellables)
  }
  
}
