//
//  Checklist.swift
//  Checklists
//
//  Created by Sascha Sallès on 27/03/2021.
//

import UIKit

class Checklist: NSObject, Codable {
  var name: String
  var items = [ChecklistItem]()
  var iconName = "Appointments"

  init(name: String, iconName: String = "No Icon") {
    self.name = name
    self.iconName = iconName
    super.init()
  }

  func countUncheckedItems() -> Int {
    return items.reduce(0) { count, item in
      count + (item.checked ? 0 : 1)
    }
  }
}
