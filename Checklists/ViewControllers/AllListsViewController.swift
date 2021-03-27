//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Sascha Sallès on 26/03/2021.
//

import UIKit

class AllListsViewController: UITableViewController {
  let cellIdentifier = "ChecklistCell"
  var dataModel: DataModel!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  // MARK: - TableView
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataModel.lists.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell!
    let checklist = dataModel.lists[indexPath.row]

    if let temp = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
      cell = temp
    } else {
      cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
    }

    if let label = cell.textLabel {
      label.text = dataModel.lists[indexPath.row].name
    }

    if let label = cell.detailTextLabel {
      let checklistCount = checklist.countUncheckedItems()
      if checklist.items.isEmpty {
        label.text = "(No Items)"
      } else {
        label.text = checklistCount == 0 ? "All Done" : "\(checklistCount) Remaining"
      }
    }

    cell.accessoryType = .detailDisclosureButton
    cell.imageView!.image = UIImage(named: checklist.iconName)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dataModel.indexOfSelectedChecklist = indexPath.row
    let checklist = dataModel.lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)

    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }

  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    guard let controller =
      storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController")
    as? ListDetailViewController else { return }
    controller.delegate = self
    let checklist = dataModel.lists[indexPath.row]
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
}

extension AllListsViewController: ListDetailViewControllerDelegate {
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }

  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
    dataModel.lists.append(checklist)
    dataModel.sortChecklists()
    tableView.reloadData()
    navigationController?.popViewController(animated: true)
  }

  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
    dataModel.sortChecklists()
    tableView.reloadData()
    navigationController?.popViewController(animated: true)
  }
}

extension AllListsViewController: UINavigationControllerDelegate {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    navigationController?.delegate = self

    let index = dataModel.indexOfSelectedChecklist
    if index >= 0 && index < dataModel.lists.count {
      let checklist = dataModel.lists[index]
      performSegue(
        withIdentifier: "ShowChecklist",
        sender: checklist)
    }
  }

  func navigationController(
    _ navigationController: UINavigationController,
    willShow viewController: UIViewController,
    animated: Bool) {
    if viewController === self {
      dataModel.indexOfSelectedChecklist = -1
    }
  }
}
