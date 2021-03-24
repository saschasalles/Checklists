//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Sascha Sallès on 23/03/2021.
//

import Foundation

class ChecklistItem {
  var text = ""
  var checked = false

  init(text: String, checked: Bool = false) {
    self.text = text
    self.checked = checked
  }
}
