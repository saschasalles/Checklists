//
//  dummy.swift
//  Checklists
//
//  Created by Sascha Sallès on 27/03/2021.
//

import Foundation

// func saveChecklistItems() {
//  let encoder = PropertyListEncoder()
//  do {
//    let data = try encoder.encode(checklist.items)
//    try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
//  } catch {
//    print("Error encoding item array: \(error.localizedDescription)")
//  }
// }
//
// func loadChecklistItems() {
//  let path = dataFilePath()
//  if let data = try? Data(contentsOf: path) {
//    let decoder = PropertyListDecoder()
//    do {
//      checklist.items = try decoder.decode(
//        [ChecklistItem].self,
//        from: data)
//    } catch {
//      print("Error decoding item array: \(error.localizedDescription)")
//    }
//  }
// }
