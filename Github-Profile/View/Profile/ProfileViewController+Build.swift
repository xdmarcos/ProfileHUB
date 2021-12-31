// 
// ProfileViewController+Build.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import UIKit

extension ProfileViewController {
	static func build(delegate: ProfileViewControllerDelegate) -> UIViewController {
		let graphQLProvider = GraphQLProvider(service: GithubService())
		let profileRepository = ProfileRepository(provider: graphQLProvider)
		let presenter = ProfilePresenter(repository: profileRepository)
		let viewController = ProfileViewController(presenter: presenter)
		viewController.delegate = delegate
		presenter.view = viewController

		return viewController
	}
}
