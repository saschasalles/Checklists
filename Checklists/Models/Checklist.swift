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

  init(name: String) {
    self.name = name
    super.init()
  }
}
