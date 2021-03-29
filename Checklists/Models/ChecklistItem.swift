//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Sascha Sallès on 23/03/2021.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID = -1

  init(text: String, checked: Bool = false) {
    super.init()
    self.itemID = DataModel.nextChecklistItemID()
    self.text = text
    self.checked = checked
  }

  deinit {
    removeNotification()
  }

  func scheduleNotification() {
    removeNotification()
    if shouldRemind && dueDate > Date() {
      let content = UNMutableNotificationContent()
      content.title = "Reminder:"
      content.body = text
      content.sound = UNNotificationSound.default

      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents(
        [.year, .month, .day, .hour, .minute],
        from: dueDate)

      let trigger = UNCalendarNotificationTrigger(
        dateMatching: components,
        repeats: false)

      let request = UNNotificationRequest(
        identifier: "\(itemID)",
        content: content,
        trigger: trigger)

      let center = UNUserNotificationCenter.current()
      center.add(request)
      print("Scheduled: \(request) for itemID: \(itemID)")
    }
  }

  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
  }
}
