//
//  MainPresenter.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI
import Combine

class MainPresenter: ObservableObject {
  
  private let useCase: MainUseCase
  private let router = MainRouter()
  
  @Published var notes: [NoteModel] = []
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMsg: String = ""
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(useCase: MainUseCase) {
    self.useCase = useCase
  }
  
  func getNotes() {
    isLoading = true
    useCase.getNotes()
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
      } receiveValue: { notes in
        let sort = notes.sorted { $0.timeInterval > $1.timeInterval }
        self.notes = sort
      }.store(in: &cancellables)
  }
  
  func removeNote(_ id: String) {
    useCase.removeNote(id: id)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMsg = error.localizedDescription
          self.isError = true
        case .finished:
          print("delete note")
        }
      } receiveValue: { _ in
      }.store(in: &cancellables)
  }
  
  func makeDetail<Content: View>(note: NoteModel, @ViewBuilder content: () -> Content) -> some View {
    return NavigationLink(destination: router.makeDetail(note: note)) { content() }
  }
  
  func makeAddNote() -> some View {
    return NavigationView { router.makeAddNote() }
  }

}
                    
