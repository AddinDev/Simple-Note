//
//  Injection.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation
import RealmSwift
import Combine

class Injection {
  
  private func provideRepo() -> Repository {
    let realm = try? Realm()
    
    let locale = LocaleDataSource.sharedInstance(realm)
    
    return Repository(locale: locale)
  }
  
  func provideMain() -> MainInteractor {
    return MainInteractor(repository: provideRepo())
  }
  
  func provideAddNote() -> AddNoteInteractor {
    return AddNoteInteractor(repository: provideRepo())
  }
  
  func provideDetail() -> DetailInteractor {
    return DetailInteractor(repository: provideRepo())
  }
  
}
