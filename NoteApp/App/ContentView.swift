//
//  ContentView.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var presenter: MainPresenter
  
    var body: some View {
      NavigationView {
        MainView(presenter: presenter)
          .navigationBarTitle("", displayMode: .inline)
          .navigationBarHidden(true)
      }
    }
  
}
