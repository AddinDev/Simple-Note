//
//  MainView.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI

struct MainView: View {
  
  @ObservedObject var presenter: MainPresenter
  @State var showAddNote = false
  
  var body: some View {
    content
      .onAppear {
        presenter.getNotes()
      }
      .sheet(isPresented: $showAddNote, onDismiss: presenter.getNotes) {
        presenter.makeAddNote()
      }
  }
  
}

extension MainView {
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle())
    }
  }
  
  var content: some View {
    VStack {
      topBar
      Group {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.notes.count == 0 {
          emptyIndicator
        } else {
          list
        }
      }
    }
  }
  
  var logo: some View {
    HStack {
      ZStack {
        Color.white
          .frame(width: 35, height: 35)
          .cornerRadius(8)
          .shadow(radius: 2)
        Image(systemName: "doc.text")
          .font(.system(size: 20))
      }
      Text("Note")
    }
  }
  
  var topBar: some View {
    HStack {
      logo
      spacer
      addNoteButton
    }
    .padding(.horizontal)
    .padding(.top, 8)
    .padding(.bottom, 5)
  }
  
  var spacer: some View {
    Spacer()
  }
  
  var emptyIndicator: some View {
    Text("Empty Note")
  }
  
  var list: some View {
    List {
      ForEach(presenter.notes) { note in
        presenter.makeDetail(note: note) {
          NoteItemView(note: note)
            .contextMenu {
              Button("Delete") {
                if let index = presenter.notes.firstIndex(of: note) {
                  presenter.removeNote(presenter.notes[index].id)
                  presenter.getNotes()
                }
              }
            }
        }
      }
      .onDelete { index in
        for i in index {
          presenter.removeNote(presenter.notes[i].id)
        }
      }
    }
    .listStyle(InsetListStyle())
  }
  
  var addNoteButton: some View {
    Button(action: {
      showAddNote = true
    }) {
      ZStack {
        Color.white
          .frame(width: 35, height: 35)
          .cornerRadius(8)
          .shadow(radius: 2)
        Image(systemName: "plus")
          .font(.system(size: 20))
          .foregroundColor(.black)
      }
    }
  }
  
}
