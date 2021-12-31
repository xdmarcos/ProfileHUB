//
// ProfileFlowResolver.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

protocol ProfileFlowResolver {
	func resolveProfileViewController(delegate: ProfileViewControllerDelegate) -> UIViewController
	func resolveProfileDetailViewController(repoId: String) -> UIViewController
	func resolveProfileAllRepositoriesViewController(repoType: Section.SectionType) -> UIViewController
}

final class ProfileFlowResolverModule: ProfileFlowResolver {
	func resolveProfileViewController(delegate: ProfileViewControllerDelegate) -> UIViewController {
		ProfileViewController.build(delegate: delegate)
	}

	func resolveProfileDetailViewController(repoId: String) -> UIViewController {
		UIViewController()
	}

	func resolveProfileAllRepositoriesViewController(repoType: Section.SectionType) -> UIViewController {
		UIViewController()
	}
}
