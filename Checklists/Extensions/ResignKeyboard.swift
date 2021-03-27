//
//  ResignKeyboard.swift
//  Checklists
//
//  Created by Sascha Sallès on 27/03/2021.
//

import Foundation
import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let screenTap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    screenTap.cancelsTouchesInView = false
    view.addGestureRecognizer(screenTap)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
