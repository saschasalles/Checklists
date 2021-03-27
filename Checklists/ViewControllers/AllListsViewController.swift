//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Sascha Sallès on 26/03/2021.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
  let cellIdentifier = "ChecklistCell"
  var lists = [Checklist]()

  override func viewDidLoad() {
    lists += [
      Checklist(name: "Birthdays"),
      Checklist(name: "Groceries"),
      Checklist(name: "Cool Apps"),
      Checklist(name: "To Do")
    ]
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

  }

  // MARK: - List Detail View Controller Delegates
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }

  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
    let newRowIndex = lists.count
    lists.append(checklist)

    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)

    navigationController?.popViewController(animated: true)
  }

  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
    if let index = lists.firstIndex(of: checklist) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = checklist.name
      }
    }
    navigationController?.popViewController(animated: true)
  }

  // MARK: - TableView
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.lists.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel!.text = lists[indexPath.row].name
    cell.accessoryType = .detailDisclosureButton
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let checklist = lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    lists.remove(at: indexPath.row)

    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }

  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {

    guard let controller =
    storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController")
    as? ListDetailViewController else { return }
    controller.delegate = self
    let checklist = lists[indexPath.row]
    controller.checklistToEdit = checklist

    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - Navigation with prepare
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowChecklist" {
      guard let controller = segue.destination as? ChecklistViewController else { return }
      controller.checklist = sender as? Checklist
    } else if segue.identifier == "AddChecklist" {
      guard let controller = segue.destination as? ListDetailViewController else { return }
      controller.delegate = self
    }
  }

  // MARK: - Data Persistence
}