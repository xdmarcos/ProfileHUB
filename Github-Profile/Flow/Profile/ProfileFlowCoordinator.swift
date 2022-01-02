//
// ProfileFlowCoordinator.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit
import Common

final class ProfileFlowCoordinator: FlowCoordination {
	private let resolver: ProfileFlowResolver
	private let navigationController: UINavigationController

	init(resolver: ProfileFlowResolver, navigationController: UINavigationController) {
		self.resolver = resolver
		self.navigationController = navigationController
	}

	func start() {
		let githubConf = Configuration.github
		let profileVC = resolver.resolveProfileViewController(delegate: self, configuration: githubConf)
		navigationController.viewControllers = [profileVC]
	}
}

extension ProfileFlowCoordinator: ProfileViewControllerDelegate {
	func navigateToDetail(repositoryID: String) {
		let detailVC = resolver.resolveProfileDetailViewController(repoId: repositoryID)
		navigationController.pushViewController(detailVC, animated: true)
	}

	func navigateToAll(of type: Section.SectionType) {
		let viewAllVC = resolver.resolveProfileAllRepositoriesViewController(repoType: type)
		navigationController.pushViewController(viewAllVC, animated: true)
	}
}
