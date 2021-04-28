//
//  DetailView.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI

struct DetailView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var presenter: DetailPresenter
  @State var isEditing = false
  @State var isDelete = false
  
  var body: some View {
    content
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(true)
      .actionSheet(isPresented: $isDelete) {
        ActionSheet(title: Text("Wanna delete this note ?"),
                    message: nil,
                    buttons: [
                      ActionSheet.Button.destructive(Text("Yes lol"),
                                                     action: {
                                                      presenter.removeNote()
                                                     }),
                      ActionSheet.Button.cancel(Text("Nope"))
                    ])
      }
  }
  
}

extension DetailView {
  
  var content: some View {
    VStack {
      topBar
      ScrollView {
        Group {
          if !isEditing {
            VStack(alignment: .leading) {
              title
              spacer
              desc
              spacer
            }
          } else {
            VStack {
              editTitle
              editDesc
            }
          }
        }
        spacer
      }
    }
  }
  
  var topBar: some View {
    HStack {
      if isEditing {
        saveButton
      } else {
        backButton
      }
      spacer
      date
      spacer
      menu
    }
    .padding(.horizontal)
    .padding(.top, 8)
    .padding(.bottom, 5)
  }
  
  var menu: some View {
    Menu {
      if isEditing {
        cancelButton
      } else {
        editButton
      }
      deleteButton
    } label: {
      ZStack {
        Color.white
          .frame(width: 35, height: 35)
          .cornerRadius(8)
          .shadow(radius: 2)
        Image(systemName: "ellipsis.circle")
          .font(.system(size: 20))
          .foregroundColor(.black)
      }
    }
  }
  
  var editButton: some View {
    Button(action: {
      withAnimation {
        isEditing = true
      }
    }) {
      Text("Edit")
    }
  }
  
  var cancelButton: some View {
    Button(action: {
      withAnimation {
        isEditing = false
      }
    }) {
      Text("Cancel")
    }
  }
  
  var saveButton: some View {
    Button(action: {
      presenter.updateNote()
      withAnimation {
        isEditing = false
      }
    }) {
      Text("Save")
        .foregroundColor(presenter.disableButton ? Color(.systemGray) : .black)
    }
    .disabled(presenter.disableButton)
  }
  
  var deleteButton: some View {
    Button(action: {
      isDelete = true
    }) {
      Text("Delete")
    }
  }
  
  var backButton: some View {
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }) {
      ZStack {
        Color.white
          .frame(width: 35, height: 35)
          .cornerRadius(8)
          .shadow(radius: 2)
        Image(systemName: "chevron.backward")
          .font(.system(size: 20))
          .foregroundColor(.black)
      }
    }
  }
  
  var spacer: some View {
    Spacer()
  }
  
  var editTitle: some View {
    TextField("", text: $presenter.title)
      .disableAutocorrection(true)
      .padding(7)
      .background(Color(.systemGray6).cornerRadius(7))
      .padding(.horizontal)
      .onAppear {
        presenter.title = presenter.note.title
      }
  }
  
  var editDesc: some View {
    TextEditor(text: $presenter.desc)
      .disableAutocorrection(true)
      .frame(minWidth: 200, maxWidth: UIScreen.main.bounds.width - 50,
             minHeight: 350, maxHeight: UIScreen.main.bounds.height - 100)
      .padding()
      .onAppear {
        presenter.desc = presenter.note.desc
      }
  }
  
  var date: some View {
    HStack {
      spacer
      Text("\(presenter.note.date) \(presenter.note.update)")
        .foregroundColor(Color(.systemGray2))
      spacer
    }
  }
  
  var title: some View {
    HStack {
      Text(presenter.note.title)
        .font(.title)
        .padding()
      spacer
    }
  }
  
  var desc: some View {
    Text(presenter.note.desc)
      .padding()
  }
  
}
