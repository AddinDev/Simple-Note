//
//  CustomErrors.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation

enum DatabaseError: LocalizedError {
  
  case invalidInstance
  case requestFailed
  case test
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    case .test: return "test"
    }
  }
  
}
