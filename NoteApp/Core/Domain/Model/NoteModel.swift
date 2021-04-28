//
//  NoteModel.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation

struct NoteModel: Identifiable, Equatable {
  
  let id: String
  let title: String
  let desc: String
  let date: String
  let update: String
  let timeInterval: String
  
}
