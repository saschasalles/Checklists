//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Sascha Sallès on 23/03/2021.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {

  func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
    navigationController?.popViewController(animated: true)
  }

  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
    let newRowIndex = items.count
    items.append(item)

    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    navigationController?.popViewController(animated: true)
  }

  var items = [ChecklistItem]()

  override func viewDidLoad() {
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    super.viewDidLoad()
    self.items += [
      ChecklistItem(text: "Walk the dog"),
      ChecklistItem(text: "Brush my teeth", checked: true),
      ChecklistItem(text: "Learn iOS development", checked: true),
      ChecklistItem(text: "Soccer practice"),
      ChecklistItem(text: "Eat ice cream")
    ]

  }

  // MARK: - Table View DataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ChecklistItem",
      for: indexPath)

    let item = items[indexPath.row]

    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    return cell
  }

  // MARK: - Table View Delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.checked.toggle()
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    items.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }

  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    guard let label = cell.viewWithTag(1001) as? UILabel else { return }

      if item.checked {
        label.text = "●"
      } else {
        label.text = "○"
      }
  }

  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    guard let label = cell.viewWithTag(1000) as? UILabel else { return }
    label.text = item.text
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItem" {
      guard let controller = segue.destination as? AddItemViewController else { return }
      controller.delegate = self
    }
  }

}
