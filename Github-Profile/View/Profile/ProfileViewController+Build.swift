// 
// ProfileViewController+Build.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

extension ProfileViewController {
	static func build() -> UIViewController {
		let presenter = ProfilePresenter()
		let viewController = ProfileViewController(presenter: presenter)
		presenter.view = viewController

		return viewController
	}
}
