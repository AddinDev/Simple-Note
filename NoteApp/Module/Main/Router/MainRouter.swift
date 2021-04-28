//
//  MainRouter.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI

class MainRouter {
  
  func makeAddNote() -> some View {
    let useCase = Injection.init().provideAddNote()
    let presenter = AddNotePresenter(useCase: useCase)
    return AddNoteView(presenter: presenter)
  }
  
  func makeDetail(note: NoteModel) -> some View {
    let useCase = Injection.init().provideDetail()
    let presenter = DetailPresenter(useCase: useCase, note: note)
    return DetailView(presenter: presenter)
  }
  
}
