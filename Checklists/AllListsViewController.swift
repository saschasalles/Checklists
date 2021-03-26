//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Sascha Sallès on 26/03/2021.
//

import UIKit

class AllListsViewController: UITableViewController {
  let cellIdentifier = "ChecklistCell"
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel!.text = "List \(indexPath.row)"
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ShowChecklist", sender: nil)
  }
}
