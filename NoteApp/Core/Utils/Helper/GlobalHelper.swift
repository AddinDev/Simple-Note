//
//  GlobalHelper.swift
//  NoteApp
//
//  Created by addin on 26/04/21.
//

import Foundation

var todaysDate: String {
  let date = Date()
  let df = DateFormatter()
  df.dateFormat = "dd MMM yyyy"
  let dateString = df.string(from: date)
  return dateString
}

var updateTime: String {
  let date = Date()
  let components = Calendar.current.dateComponents([.hour, .minute], from: date)
  let hour = components.hour ?? 0
  let minute = components.minute ?? 0
  
  var h: String {
    if String(hour).count == 1 {
      return "0\(hour)"
    }
    return String(hour)
  }
  
  var m: String {
    if String(minute).count == 1 {
      return "0\(minute)"
    }
    return String(minute)
  }

  return "\(h).\(m)"
}
