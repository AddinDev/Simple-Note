//
//  NoteItemView.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI

struct NoteItemView: View {
  
  var note: NoteModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      HStack {
        Text(note.title)
          .lineLimit(1)
        Spacer()
        Text(note.date)
          .foregroundColor(Color(.systemGray2))
      }
      Text(note.desc)
        .foregroundColor(Color(.systemGray))
        .lineLimit(2)
    }
    .padding(8)
  }
  
}
