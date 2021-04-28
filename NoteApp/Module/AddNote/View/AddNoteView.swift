//
//  AddTaskView.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI

struct AddNoteView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var presenter: AddNotePresenter
  
  var body: some View {
    if presenter.isLoading {
      loadingIndicator
    } else {
      content
        .navigationBarTitle("Add Note")
        .navigationBarItems(leading: backButton, trailing: saveButton)
    }
  }
  
}

extension AddNoteView {
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
    }
  }
  
  var content: some View {
    VStack {
      TextField("Title", text: $presenter.title)
        .disableAutocorrection(true)
        .padding(7)
        .background(Color(.systemGray6).cornerRadius(7))
        .padding(.horizontal)
      
      TextEditor(text: $presenter.desc)
        .multilineTextAlignment(.leading)
        .disableAutocorrection(true)
        .padding(7)
        .frame(minWidth: 200, maxWidth: UIScreen.main.bounds.width - 50,
               minHeight: 200, maxHeight: UIScreen.main.bounds.height - 100)
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .stroke(Color(.systemGray4), style: StrokeStyle(lineWidth: 2, dash: [10]))
        )
        .padding([.horizontal, .bottom])
        .padding(.top, 4)
    }
  }
  
  var saveButton: some View {
    Button(action: {
      presenter.addNote()
      self.presentationMode.wrappedValue.dismiss()
    }) {
        Text("Save")
          .foregroundColor(presenter.disableButton ? Color(.systemGray) : .black)
    }
    .disabled(presenter.disableButton)
  }
  
  var backButton: some View {
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }) {
      Image(systemName: "xmark")
        .foregroundColor(.black)
    }
  }
  
}
