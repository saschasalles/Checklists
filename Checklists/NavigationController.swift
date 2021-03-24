//
//  NavigationController.swift
//  Checklists
//
//  Created by Sascha Sallès on 24/03/2021.
//

import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

  private func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
