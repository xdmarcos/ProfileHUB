//
// ProfileFlowResolver.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

protocol ProfileFlowResolver {
	func resolveProfileViewController(delegate: ProfileViewControllerDelegate, configuration: Required) -> UIViewController
	func resolveProfileDetailViewController(repoId: String) -> UIViewController
	func resolveProfileAllRepositoriesViewController(repoType: Section.SectionType) -> UIViewController
}

final class ProfileFlowResolverModule: ProfileFlowResolver {
	func resolveProfileViewController(delegate: ProfileViewControllerDelegate, configuration: Required) -> UIViewController {
		ProfileViewController.build(delegate: delegate, configuration: configuration)
	}

	func resolveProfileDetailViewController(repoId: String) -> UIViewController {
		RepositoryDetailViewController()
	}

	func resolveProfileAllRepositoriesViewController(repoType: Section.SectionType) -> UIViewController {
		RepositoryAllViewController()
	}
}
