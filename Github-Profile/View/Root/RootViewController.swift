//
//  RootViewController.swift
//  Github-Profile
//
//  Created by Marcos González on 2021.
//

import UIKit

class RootViewController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()

		viewControllers = [ProfileViewController.build()]
	}
}
