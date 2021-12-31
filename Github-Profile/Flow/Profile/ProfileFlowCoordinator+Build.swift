//
// ProfileFlowCoordinator+Build.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

extension ProfileFlowCoordinator {
	static func build(navigationController: UINavigationController) -> ProfileFlowCoordinator {
		let resolver = ProfileFlowResolverModule()
		let coordinator = ProfileFlowCoordinator(
			resolver: resolver,
			navigationController: navigationController
		)
		return coordinator
	}
}
