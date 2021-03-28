//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Sascha Sallès on 23/03/2021.
//

import Foundation

class ChecklistItem: NSObject, Codable {
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID = -1

  override init(text: String, checked: Bool = false) {
    super.init()
    self.itemID = DataModel.nextChecklistItemID()
    self.text = text
    self.checked = checked
  }
}
